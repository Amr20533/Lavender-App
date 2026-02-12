import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/features/programs/data/models/diary_entry.dart';
import 'package:lavender/features/programs/data/repositories/diary_repository.dart';

class WriteEntryPage extends StatefulWidget {
  final String? initialText;

  const WriteEntryPage({Key? key, this.initialText}) : super(key: key);

  @override
  _WriteEntryPageState createState() => _WriteEntryPageState();
}

class _WriteEntryPageState extends State<WriteEntryPage> {
  int? selectedMood;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.initialText);
  }

  final List<Map<String, dynamic>> moods = [
    {'emoji': '😡', 'label': 'غاضب جداً', 'color': Color(0xFFEF4444)},
    {'emoji': '☹️', 'label': 'حزين', 'color': Color(0xFFF97316)},
    {'emoji': '😐', 'label': 'غير مبال', 'color': Color(0xFFFBBF24)},
    {'emoji': '🙂', 'label': 'سعيد', 'color': Color(0xFFA3E635)},
    {'emoji': '😄', 'label': 'سعيد جداً', 'color': Color(0xFF22C55E)},
  ];

  String _getArabicDate() {
    final now = DateTime.now();
    final weekdays = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    final months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    return '${weekdays[now.weekday - 1]}، ${now.day} ${months[now.month - 1]} ${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFFFFBF0),
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFBF0),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'مذكراتي',
            style: TextStyle(
              color: Color(0xFF333333),
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
              icon: Icon(Icons.more_horiz, color: Color(0xFF8B7FD8)),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // التاريخ
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    _getArabicDate(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8B7FD8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(height: 8),

                // اختيار المود
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF8B7FD8).withOpacity(0.08),
                        blurRadius: 15,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'كيف تشعر اليوم؟',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          moods.length,
                              (index) => _buildMoodButton(index),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // صفحة الكتابة
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF8B7FD8).withOpacity(0.1),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // خطوط الدفتر
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            children: List.generate(
                              13,
                                  (index) => Container(
                                margin: EdgeInsets.only(bottom: 28),
                                height: 1,
                                color: Color(0xFFF0F0F0),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // الإيموجي المختار (لو موجود)
                      if (selectedMood != null)
                        Positioned(
                          top: 20,
                          right: 20,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: moods[selectedMood!]['color'].withOpacity(
                                0.15,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                moods[selectedMood!]['emoji'],
                                style: TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                        ),

                      // مساحة الكتابة
                      Padding(
                        padding: EdgeInsets.only(
                          top: selectedMood != null ? 85 : 20,
                          right: 20,
                          left: 20,
                          bottom: 20,
                        ),
                        child: TextField(
                          controller: textController,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF333333),
                            height: 2.0,
                          ),
                          decoration: InputDecoration(
                            hintText: 'ابدأ بكتابة يومياتك هنا...',
                            hintStyle: TextStyle(
                              color: Color(0xFFCCCCCC),
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // زر الحفظ
                ElevatedButton(
                  onPressed: () async {
                    if (selectedMood != null &&
                        textController.text.isNotEmpty) {
                      final entry = DiaryEntry(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        text: textController.text,
                        emoji: moods[selectedMood!]['emoji'],
                        colorValue: moods[selectedMood!]['color'].value,
                        date: DateTime.now(),
                      );

                      await DiaryRepository.saveEntry(entry);

                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم حفظ اليومية بنجاح! 💜'),
                            backgroundColor: Color(0xFF8B7FD8),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.pop(context);
                        });
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('من فضلك اختر مزاجك واكتب شيئاً'),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: Text(
                    'حفظ اليومية',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8B7FD8),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoodButton(int index) {
    bool isSelected = selectedMood == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMood = index;
        });
      },
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color:
              isSelected
                  ? moods[index]['color'].withOpacity(0.15)
                  : Color(0xFFF5F5F5),
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? moods[index]['color'] : Colors.grey[300]!,
                width: isSelected ? 2.5 : 1.5,
              ),
            ),
            child: Center(
              child: Text(
                moods[index]['emoji'],
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}