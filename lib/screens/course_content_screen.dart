import 'package:flutter/material.dart';
import '../config.dart';
import '../models/course.dart';
import '../widgets/lesson_tile.dart';

class CourseContentScreen extends StatefulWidget {
  const CourseContentScreen({super.key});

  @override
  State<CourseContentScreen> createState() => _CourseContentScreenState();
}

class _CourseContentScreenState extends State<CourseContentScreen> {
  int _selectedTabIndex = 0;
  final List<LessonItem> _lessons = [];
  final List<LessonItem> _exams = [];
  final List<LessonItem> _ideas = [];
  final List<LessonItem> _grammar = [];
  final List<CourseTab> _tabs = [];
  String _pageTitle = 'الدورة المكثفة';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _loadContent();
  }

  void _loadContent() {
    const data = AppConfig.intensiveScientificData;
    _pageTitle = data['title'] ?? 'الدورة المكثفة';
    _tabs.clear();
    _tabs.addAll(
      (data['tabs'] as List).map(
        (t) => CourseTab(
          name: t['name'],
          title: t['title'],
          icon: t['icon'],
          type: t['type'],
        ),
      ),
    );
    _lessons.clear();
    _lessons.addAll(
      (data['lessons'] as List).map(
        (l) => LessonItem(
          id: l['id'],
          youtubeId: l['youtubeId'],
          title: l['title'],
        ),
      ),
    );
    _exams.clear();
    _exams.addAll(
      (data['exams'] as List).map(
        (e) => LessonItem(
          id: e['id'],
          youtubeId: e['youtubeId'],
          title: e['title'],
        ),
      ),
    );
    _ideas.clear();
    _ideas.addAll(
      (data['ideas'] as List).map(
        (i) => LessonItem(
          id: i['id'],
          youtubeId: i['youtubeId'],
          title: i['title'],
        ),
      ),
    );
    _grammar.clear();
    _grammar.addAll(
      (data['grammar'] as List).map(
        (g) => LessonItem(
          id: g['id'],
          youtubeId: g['youtubeId'],
          title: g['title'],
        ),
      ),
    );
  }

  List<LessonItem> _getCurrentItems() {
    switch (_selectedTabIndex) {
      case 0:
        return _lessons;
      case 1:
        return _exams;
      case 2:
        return _ideas;
      case 3:
        return _grammar;
      default:
        return _lessons;
    }
  }

  String _getCurrentType() {
    switch (_selectedTabIndex) {
      case 0:
        return 'lesson';
      case 1:
        return 'basmiyat';
      case 2:
        return 'ideas';
      case 3:
        return 'grammar';
      default:
        return 'lesson';
    }
  }

  void _openVideo(String videoId, String title) {
    Navigator.pushNamed(
      context,
      '/video_player',
      arguments: {'videoId': videoId, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _getCurrentItems();

    return Scaffold(
      appBar: AppBar(title: Text(_pageTitle)),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppConfig.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _tabs.asMap().entries.map((e) {
                  final isActive = _selectedTabIndex == e.key;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Material(
                      color: isActive
                          ? AppConfig.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () => setState(() => _selectedTabIndex = e.key),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                e.value.icon == 'play_circle'
                                    ? Icons.play_circle
                                    : e.value.icon == 'description'
                                    ? Icons.description
                                    : e.value.icon == 'lightbulb'
                                    ? Icons.lightbulb
                                    : Icons.book,
                                size: 18,
                                color: isActive
                                    ? Colors.white
                                    : AppConfig.darkText,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                e.value.title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isActive
                                      ? Colors.white
                                      : AppConfig.darkText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppConfig.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _stat('${_lessons.length}', 'نصوص'),
                _stat('${_exams.length}', 'بصميات'),
                _stat('${_ideas.length}', 'أفكار'),
                _stat('${_grammar.length}', 'قواعد'),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: AppConfig.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: items.isEmpty
                    ? const Center(
                        child: Text(
                          'لا توجد دروس متاحة',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppConfig.lightText,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (_, i) => LessonTile(
                          lesson: items[i],
                          type: _getCurrentType(),
                          onTap: () =>
                              _openVideo(items[i].youtubeId, items[i].title),
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppConfig.primaryColor,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppConfig.lightText),
        ),
      ],
    );
  }
}
