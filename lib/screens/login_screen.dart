import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final result = await _authService.fullLogin(
      _usernameController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result['message'] ?? ''),
        backgroundColor: result['success'] == true
            ? AppConfig.successColor
            : AppConfig.errorColor,
      ),
    );

    if (result['success'] == true) {
      Navigator.pushReplacementNamed(
        context,
        '/branch_selection',
        arguments: {'courseType': 'full'},
      );
    }
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null && data!.text!.isNotEmpty) {
      _usernameController.text = data.text!;
    }
  }

  Future<void> _contactAdmin() async {
    final url = Uri.parse(
      '${AppConfig.whatsappUrl}?text=${AppConfig.whatsappMessage}',
    );
    if (await canLaunchUrl(url))
      await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  color: AppConfig.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppConfig.primaryColor.withValues(alpha: 0.15),
                      blurRadius: 40,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      decoration: const BoxDecoration(
                        gradient: AppConfig.primaryGradient,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            AppConfig.appName,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'منصة اليونسيون التعليمية',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'اسم المستخدم',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppConfig.darkText,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Stack(
                            children: [
                              TextFormField(
                                controller: _usernameController,
                                textInputAction: TextInputAction.go,
                                onFieldSubmitted: (_) => _handleLogin(),
                                validator: (v) => v == null || v.trim().isEmpty
                                    ? 'يجب إدخال اسم المستخدم'
                                    : null,
                                decoration: const InputDecoration(
                                  hintText: 'أدخل اسم المستخدم',
                                  contentPadding: EdgeInsets.only(
                                    left: 80,
                                    right: 20,
                                    top: 18,
                                    bottom: 18,
                                  ),
                                ),
                                style: const TextStyle(fontSize: 16),
                              ),
                              Positioned(
                                left: 5,
                                top: 5,
                                bottom: 5,
                                child: Material(
                                  color: AppConfig.secondaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  child: InkWell(
                                    onTap: _pasteFromClipboard,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: 70,
                                      alignment: Alignment.center,
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.paste,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'لصق',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleLogin,
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : const Text(
                                      'تسجيل الدخول',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Center(
                            child: GestureDetector(
                              onTap: _contactAdmin,
                              child: RichText(
                                text: const TextSpan(
                                  text: 'ليس لديك حساب؟ ',
                                  style: TextStyle(
                                    color: AppConfig.lightText,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'تواصل مع المسؤول',
                                      style: TextStyle(
                                        color: AppConfig.primaryColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
