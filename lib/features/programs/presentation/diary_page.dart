import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/app_bar_shadow.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/features/programs/data/models/diary_entry.dart';
import 'package:lavender/features/programs/data/repositories/diary_repository.dart';
import 'package:lavender/features/programs/presentation/diary_history_page.dart';
import 'package:lavender/features/programs/presentation/widgets/diary_hitory_card.dart';
import 'package:lavender/features/programs/presentation/widgets/quote_card.dart';
import 'package:lavender/features/programs/presentation/widgets/writing_propting_card.dart';
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
          leading: BackIcon(),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: AppBarShadow(),
          ),
          actions: [
            // IconButton(
            //   icon: Icon(Icons.settings, color: AppColors.lightBlack),
            //   onPressed: () {},
            // ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                QuoteCard(),

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
                        return DiaryHistoryCard(entry: entries[index]);
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
                    .map((prompt) => WritingPromptCard(prompt: prompt, onEntrySaved: () {  },))
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
}

