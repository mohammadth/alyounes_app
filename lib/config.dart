import 'package:flutter/material.dart';

class AppConfig {
  // ========== معلومات التطبيق ==========
  static const String appName = 'اليونسيون';
  static const String appNameEnglish = 'Al Younes';
  static const String version = '1.0.0';

  // ========== الألوان ==========
  static const Color primaryColor = Color(0xFF6D256F);
  static const Color primaryLight = Color(0xFF8D2E8F);
  static const Color secondaryColor = Color(0xFF1EBAA6);
  static const Color secondaryLight = Color(0xFF2AD4BD);
  static const Color accentColor = Color(0xFFFF6B9D);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color darkText = Color(0xFF2D3748);
  static const Color lightText = Color(0xFF666666);
  static const Color white = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFFF4757);
  static const Color successColor = Color(0xFF2ED573);
  static const Color warningColor = Color(0xFFFFA502);
  static const Color statusBarColor = Color(0xFF772879);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6D256F), Color(0xFF8D2E8F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF1EBAA6), Color(0xFF2AD4BD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ========== السيرفر والروابط ==========
  static const String baseUrl = 'https://khoja.host1.innova-tecs.com';
  static const String fullLoginUrl = '$baseUrl/full.login/login.php';
  static const String efLoginUrl = '$baseUrl/ef.login/login.php';
  static const String examsLoginUrl = '$baseUrl/login.exam/login.php';
  static const String registerDeviceUrl = '$baseUrl/full.login/register_device.php';
  static const String videoPlayerUrl = '$baseUrl/full.lesson/video_player.html';
  static const String examsPageUrl = '$baseUrl/full.exam/';
  static const String updateApiUrl = '$baseUrl/full.login/update/api.php';

  // ========== أرقام التواصل ==========
  static const String whatsappNumber = '963982717795';
  static const String whatsappUrl = 'https://wa.me/$whatsappNumber';
  static const String whatsappMessage = 'السلام+عليكم%0Aأحتاج+مساعدة+بخصوص+*تطبيق+اليونسيون*';

  // ========== مفاتيح التخزين ==========
  static const String fullLoginPref = 'login_pref';
  static const String efLoginPref = 'ef_pref';
  static const String examsLoginPref = 'exam_pref';

  // ========== بيانات الدروس (المكثفة - علمي) ==========
  static const Map<String, dynamic> intensiveScientificData = {
    'title': 'الدورة المكثفة - القسم العلمي',
    'description': 'دورة مكثفة لمادة الإنجليزية للقسم العلمي تشمل النصوص، البصميات، أفكار القالب، وقواعد اللغة.',
    'tabs': [
      {'name': 'lessons', 'title': 'نصوص علمي', 'icon': 'play_circle', 'type': 'lessons'},
      {'name': 'exams', 'title': 'بصميات علمي', 'icon': 'description', 'type': 'exams'},
      {'name': 'ideas', 'title': 'أفكار القالب', 'icon': 'lightbulb', 'type': 'ideas'},
      {'name': 'grammar', 'title': 'قواعد', 'icon': 'book', 'type': 'grammar'}
    ],
    'lessons': [
      {'id': 1, 'youtubeId': 'LpXlomFrTeQ', 'title': 'نصوص علمي 1'},
      {'id': 2, 'youtubeId': 'lm0TvJBcYqk', 'title': 'نصوص علمي 2'},
      {'id': 3, 'youtubeId': '0FYFnMeYlKA', 'title': 'نصوص علمي 3'},
      {'id': 4, 'youtubeId': 'FFynBIJIZNI', 'title': 'نصوص علمي 4'},
    ],
    'exams': [
      {'id': 1, 'youtubeId': 'bYGHB6Wt3dU', 'title': 'بصميات 1'},
      {'id': 2, 'youtubeId': '9XN8wDAdZV4', 'title': 'بصميات 2'},
      {'id': 3, 'youtubeId': 'ES57WfRE7gA', 'title': 'بصميات 3'},
      {'id': 4, 'youtubeId': 'ALNXV9QNAck', 'title': 'بصميات 4'},
    ],
    'ideas': [
      {'id': 1, 'youtubeId': '6oZvksdiAvY', 'title': 'فراغ ذاكرة واكمال جمل'},
      {'id': 2, 'youtubeId': 'L_hfwaoZeUQ', 'title': 'تشكيل السؤال وترجمة'},
      {'id': 3, 'youtubeId': '1HbRII4dvaA', 'title': 'موضوع'},
    ],
    'grammar': [
      {'id': 1, 'youtubeId': 'qqR3RoXnx40', 'title': 'الجزء الأول'},
      {'id': 2, 'youtubeId': '2aOcQ_LyPe4', 'title': 'الجزء الثاني'},
      {'id': 3, 'youtubeId': 'oqfXx2e1Xn8', 'title': 'الجزء الثالث'},
      {'id': 4, 'youtubeId': '5n9eZuLdev4', 'title': 'الجزء الرابع'},
    ],
  };
}