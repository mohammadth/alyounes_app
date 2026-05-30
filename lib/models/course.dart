class Course {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String type;
  final List<String> features;
  final bool locked;
  final String message;
  final String targetRoute;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.type,
    required this.features,
    this.locked = false,
    this.message = '',
    required this.targetRoute,
  });

  static List<Course> getScientificCourses() {
    return [
      Course(
        id: 'full_course',
        title: 'الدورة الكاملة',
        description: 'رحلة شاملة تغطي كامل المنهاج للوصول إلى الاتقان',
        icon: 'school',
        type: 'full',
        features: ['12 وحدات تعليمية متكاملة', '36 درس مفصل', '36 اختبار تفاعلي'],
        locked: false,
        targetRoute: '/login',
      ),
      Course(
        id: 'intensive',
        title: 'الدورة المكثفة',
        description: 'مراجعة مركزة لأهم النقاط والمفاهيم في وقت قصير',
        icon: 'bolt',
        type: 'intensive',
        features: ['اعادة شاملة لأفكار المنهاج', 'حل تمارين سريعة', 'ملخص كامل للنصوص'],
        locked: false,
        targetRoute: '/ef_login',
      ),
      Course(
        id: 'exam_session',
        title: 'الجلسة الامتحانية',
        description: 'تحضير مكثف للامتحان مع نماذج وأسئلة متوقعة وحلول إرشادية',
        icon: 'assignment',
        type: 'exam',
        features: ['اعادة سريعة للافكار', 'نصائح هامة للامتحان', 'ملخصات لكل قسم'],
        locked: true,
        message: 'ستتوفر في فترة الامتحانات',
        targetRoute: '/exams_login',
      ),
    ];
  }
}

class LessonItem {
  final int id;
  final String youtubeId;
  final String title;

  LessonItem({required this.id, required this.youtubeId, required this.title});

  factory LessonItem.fromJson(Map<String, dynamic> json) {
    return LessonItem(
      id: json['id'] ?? 0,
      youtubeId: json['youtubeId'] ?? '',
      title: json['title'] ?? '',
    );
  }
}

class CourseTab {
  final String name;
  final String title;
  final String icon;
  final String type;

  CourseTab({required this.name, required this.title, required this.icon, required this.type});

  factory CourseTab.fromJson(Map<String, dynamic> json) {
    return CourseTab(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      icon: json['icon'] ?? 'play_circle',
      type: json['type'] ?? 'lessons',
    );
  }
}