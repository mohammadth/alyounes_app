import 'package:flutter/material.dart';
import '../config.dart';
import '../models/course.dart';

class LessonTile extends StatelessWidget {
  final LessonItem lesson;
  final VoidCallback onTap;
  final String type;

  const LessonTile({super.key, required this.lesson, required this.onTap, this.type = 'lesson'});

  @override
  Widget build(BuildContext context) {
    final Color color = type == 'basmiyat'
        ? const Color(0xFFFF6B6B)
        : type == 'ideas'
            ? AppConfig.accentColor
            : type == 'grammar'
                ? const Color(0xFFFF5722)
                : AppConfig.primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0)))),
        child: Row(children: [
          Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Center(child: Text('${lesson.id}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)))),
          const SizedBox(width: 15),
          Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(lesson.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppConfig.darkText)),
            const SizedBox(height: 5),
            Row(children: [
              Icon(type == 'basmiyat' ? Icons.quiz : type == 'ideas' ? Icons.lightbulb : Icons.play_circle, size: 14, color: AppConfig.lightText),
              const SizedBox(width: 5),
              Text(type == 'basmiyat' ? 'بصميات' : type == 'ideas' ? 'فكرة قالب' : 'فيديو تعليمي',
                  style: const TextStyle(fontSize: 13, color: AppConfig.lightText)),
            ]),
          ])),
          Container(
              width: 45, height: 45,
              decoration: const BoxDecoration(gradient: AppConfig.primaryGradient, shape: BoxShape.circle),
              child: const Icon(Icons.play_arrow, color: Colors.white, size: 24)),
        ]),
      ),
    );
  }
}