import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/features/programs/data/models/diary_entry.dart';
import 'package:lavender/features/programs/data/repositories/diary_repository.dart';
import 'package:lavender/features/programs/presentation/diary_history_page.dart';
import 'package:lavender/features/programs/presentation/write_entry_page.dart';

class EmptyDiaryPage extends StatefulWidget {
  @override
  _EmptyDiaryPageState createState() => _EmptyDiaryPageState();
}

class _EmptyDiaryPageState extends State<EmptyDiaryPage> {
  List<DiaryEntry> entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() {
    setState(() {
      entries = DiaryRepository.getAllEntries();
    });
  }

  final List<Map<String, dynamic>> prompts = [
    {
      'title': 'ممتن لـ...',
      'subtitle': 'ما هي الأشياء الثلاثة التي تسعدك اليوم؟',
      'icon': Icons.favorite,
      'color': Color(0xFFFFB7B7),
      'prompt': 'أنا ممتن اليوم لـ:\n1. \n2. \n3. ',
    },
    {
      'title': 'نوايا اليوم',
      'subtitle': 'ما هو هدفك الرئيسي لهذا اليوم؟',
      'icon': Icons.lightbulb,
      'color': Color(0xFFB7E4C7),
      'prompt': 'هدفي الرئيسي اليوم هو: ',
    },
    {
      'title': 'تفريغ مشاعر',
      'subtitle': 'كيف تشعر الآن؟ وماذا يدور في ذهنك؟',
      'icon': Icons.cloud,
      'color': Color(0xFFB7D1F2),
      'prompt': 'أشعر اليوم بـ... لأن... ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.w,
        appBar: AppBar(
          backgroundColor: AppColors.w,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'يومياتي',
            style: TextStyle(
              color: AppColors.lightBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.lightBlack,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: AppColors.lightBlack),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // اقتباس اليوم
                _buildQuoteCard(),

                SizedBox(height: 32),

                // قسم اليوميات المكتوبة (لو فيه)
                if (entries.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'يومياتك الأخيرة',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiaryHistoryPage(),
                            ),
                          );
                        },
                        child: Text(
                          'عرض الكل',
                          style: TextStyle(
                            color: Color(0xFF8B7FD8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: entries.length,
                      itemBuilder: (context, index) {
                        return _buildHistoryCard(entries[index]);
                      },
                    ),
                  ),
                  SizedBox(height: 32),
                ],

                Text(
                  'ابدأي الكتابة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),

                SizedBox(height: 16),

                // قائمة المحفزات
                ...prompts
                    .map((prompt) => _buildPromptCard(context, prompt))
                    .toList(),

                SizedBox(height: 24),

                // زر الكتابة الحرة
                Center(
                  child: TextButton.icon(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WriteEntryPage(),
                        ),
                      ).then((_) => _loadEntries());
                    },
                    icon: Icon(Icons.edit, color: Color(0xFF8B7FD8)),
                    label: Text(
                      'أو ابدأ كتابة حرة',
                      style: TextStyle(
                        color: Color(0xFF8B7FD8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(DiaryEntry entry) {
    String dateStr = "${entry.date.day}/${entry.date.month}/${entry.date.year}";
    return Container(
      width: 160,
      margin: EdgeInsetsDirectional.only(end: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(entry.colorValue).withOpacity(0.12),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Color(entry.colorValue).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateStr,
                style: TextStyle(fontSize: 11, color: Colors.grey[700]),
              ),
              Text(entry.emoji, style: TextStyle(fontSize: 18)),
            ],
          ),
          SizedBox(height: 12),
          Expanded(
            child: Text(
              entry.text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF333333),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFF8B7FD8),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF8B7FD8).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.format_quote,
            color: Colors.white.withValues(alpha: 0.5),
            size: 40,
          ),
          Text(
            '"كل يوم هو بداية جديدة، خذي نفساً عميقاً وابتسمي."',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.6,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'نصيحة اليوم',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromptCard(BuildContext context, Map<String, dynamic> prompt) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WriteEntryPage(initialText: prompt['prompt']),
          ),
        ).then((_) => _loadEntries());
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: prompt['color'].withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                prompt['icon'],
                color: prompt['color'].withOpacity(0.8),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prompt['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    prompt['subtitle'],
                    style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_back_ios_new, size: 14, color: Color(0xFFCCCCCC)),
          ],
        ),
      ),
    );
  }
}