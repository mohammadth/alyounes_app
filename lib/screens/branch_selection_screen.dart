import 'package:flutter/material.dart';
import '../config.dart';

class BranchSelectionScreen extends StatelessWidget {
  const BranchSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final courseType = args['courseType'] ?? 'full';

    return Scaffold(
      appBar: AppBar(title: const Text('اختيار الفرع')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: AppConfig.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.school, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                AppConfig.appName,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppConfig.primaryColor,
                ),
              ),
              const SizedBox(height: 50),
              _buildCard(
                context,
                'الفرع العلمي',
                'شروحات مفصلة حتى تصل إلى العلامة التامة',
                Icons.science,
                AppConfig.primaryGradient,
                () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/course_content',
                    arguments: {
                      'courseType': courseType,
                      'branch': 'scientific',
                    },
                  );
                },
              ),
              const SizedBox(height: 25),
              _buildCard(
                context,
                'الفرع الأدبي',
                'شروحات مفصلة حتى تصل إلى العلامة التامة',
                Icons.book,
                AppConfig.secondaryGradient,
                () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/course_content',
                    arguments: {'courseType': courseType, 'branch': 'literary'},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    String desc,
    IconData icon,
    LinearGradient gradient,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: AppConfig.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppConfig.primaryColor.withValues(alpha: 0.15),
              blurRadius: 40,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppConfig.lightText,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
