import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config.dart';
import '../models/course.dart';
import '../widgets/course_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openWhatsApp() async {
    final url = Uri.parse(
      '${AppConfig.whatsappUrl}?text=${AppConfig.whatsappMessage}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final courses = Course.getScientificCourses();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppConfig.primaryColor, AppConfig.backgroundColor],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  AppConfig.appName,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.help_outline, color: Colors.white),
                    onPressed: _openWhatsApp,
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'اختر القسم الذي تريد دراسته',
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      ...courses.map(
                        (course) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CourseCard(
                            course: course,
                            onTap: () {
                              if (course.locked) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(course.message),
                                    backgroundColor: AppConfig.warningColor,
                                  ),
                                );
                                return;
                              }
                              Navigator.pushNamed(
                                context,
                                course.targetRoute,
                                arguments: {
                                  'courseType': course.type,
                                  'courseId': course.id,
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'أقسام إضافية',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                _buildBtn(
                                  context,
                                  Icons.book,
                                  'المفردات',
                                  '/webview',
                                  args: {
                                    'title': 'المفردات',
                                    'htmlFile': 'vocabulary.html',
                                  },
                                ),
                                const SizedBox(width: 15),
                                _buildBtn(
                                  context,
                                  Icons.calendar_month,
                                  'الخطة الدراسية',
                                  '/webview',
                                  args: {
                                    'title': 'الخطة الدراسية',
                                    'htmlFile': 'programs.html',
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                _buildBtn(
                                  context,
                                  Icons.download,
                                  'قائمة التحميل',
                                  '/webview',
                                  args: {
                                    'title': 'قائمة التحميل',
                                    'htmlFile': 'download_list.html',
                                  },
                                ),
                                const SizedBox(width: 15),
                                _buildBtn(
                                  context,
                                  Icons.play_circle,
                                  'الفيديوهات المحملة',
                                  '/webview',
                                  args: {
                                    'title': 'الفيديوهات المحملة',
                                    'htmlFile': 'downloaded_videos.html',
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBtn(
    BuildContext context,
    IconData icon,
    String label,
    String route, {
    Map<String, dynamic>? args,
  }) {
    return Expanded(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, route, arguments: args),
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: AppConfig.primaryColor, size: 30),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppConfig.darkText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
