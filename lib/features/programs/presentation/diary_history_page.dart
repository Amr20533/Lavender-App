import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/features/programs/data/models/diary_entry.dart';
import 'package:lavender/features/programs/data/repositories/diary_repository.dart';

class DiaryHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entries = DiaryRepository.getAllEntries();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.w,
        appBar: AppBar(
          backgroundColor: AppColors.w,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'سجل اليوميات',
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
        ),
        body:
        entries.isEmpty
            ? Center(
          child: Text(
            'لا توجد يوميات بعد',
            style: TextStyle(color: Colors.grey),
          ),
        )
            : ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: entries.length,
          itemBuilder: (context, index) {
            return _buildHistoryItem(entries[index]);
          },
        ),
      ),
    );
  }

  Widget _buildHistoryItem(DiaryEntry entry) {
    String dateStr = "${entry.date.day}/${entry.date.month}/${entry.date.year}";

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: Color(entry.colorValue).withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Color(entry.colorValue).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(entry.emoji, style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    dateStr,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                ],
              ),
              Icon(Icons.more_vert, size: 20, color: Colors.grey[400]),
            ],
          ),
          SizedBox(height: 12),
          Text(
            entry.text,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}