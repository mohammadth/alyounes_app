import 'package:flutter/material.dart';
import '../config.dart';
import '../models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const CourseCard({super.key, required this.course, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color accentColor = course.type == 'intensive'
        ? AppConfig.secondaryColor
        : course.type == 'exam'
        ? const Color(0xFFFF6B6B)
        : AppConfig.primaryColor;

    final IconData icon = course.icon == 'bolt'
        ? Icons.bolt
        : course.icon == 'assignment'
        ? Icons.assignment
        : Icons.school;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppConfig.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.15),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accentColor, accentColor.withValues(alpha: 0.8)],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(icon, size: 40, color: Colors.white),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: course.locked
                                ? Colors.white.withValues(alpha: 0.3)
                                : AppConfig.secondaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            course.locked ? 'مقفل' : 'متاح',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppConfig.lightText,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...course.features.map(
                    (f) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: accentColor,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              f,
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppConfig.darkText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (course.locked) ...[
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3CD),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xFFFFEAA7)),
                      ),
                      child: Text(
                        course.message,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF856404),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: course.locked ? null : onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: course.locked
                            ? Colors.grey
                            : accentColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        course.locked ? 'غير متاح حالياً' : 'اختر الدورة',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
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
    );
  }
}
