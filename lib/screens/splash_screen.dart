import 'package:flutter/material.dart';
import '../config.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _controller.forward();
    _checkLoginAndNavigate();
  }

  Future<void> _checkLoginAndNavigate() async {
    final authService = AuthService();
    final storageService = StorageService();
    await authService.registerDevice();
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    // التحقق من وجود تسجيل دخول سابق لأي قسم
    final fullUser = await storageService.getUsername(AppConfig.fullLoginPref);
    final efUser = await storageService.getUsername(AppConfig.efLoginPref);
    final examsUser = await storageService.getUsername(
      AppConfig.examsLoginPref,
    );

    if (!mounted) return;

    if (fullUser != null && fullUser.isNotEmpty) {
      final result = await authService.fullLogin(fullUser);
      if (result['success'] == true) {
        Navigator.pushReplacementNamed(
          context,
          '/branch_selection',
          arguments: {'courseType': 'full'},
        );
        return;
      } else {
        await authService.logout(AppConfig.fullLoginPref);
      }
    }

    if (efUser != null && efUser.isNotEmpty) {
      final result = await authService.efLogin(efUser);
      if (result['success'] == true) {
        Navigator.pushReplacementNamed(
          context,
          '/branch_selection',
          arguments: {'courseType': 'intensive'},
        );
        return;
      } else {
        await authService.logout(AppConfig.efLoginPref);
      }
    }

    if (examsUser != null && examsUser.isNotEmpty) {
      final result = await authService.examsLogin(examsUser);
      if (result['success'] == true) {
        Navigator.pushReplacementNamed(
          context,
          '/webview',
          arguments: {'title': 'الاختبارات', 'url': AppConfig.examsPageUrl},
        );
        return;
      } else {
        await authService.logout(AppConfig.examsLoginPref);
      }
    }

    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppConfig.primaryGradient),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.school,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      AppConfig.appName,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'المنصة التعليمية المتطورة',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.8),
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    const SizedBox(height: 60),
                    const SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2.5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
