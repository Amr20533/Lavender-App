import 'package:flutter/material.dart';
import 'package:lavender/features/programs/data/models/diary_entry.dart';

class DiaryHistoryCard extends StatelessWidget {
  final DiaryEntry entry;

  const DiaryHistoryCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    // تنسيق التاريخ بصيغة dd/mm/yyyy
    final String dateStr = "${entry.date.day}/${entry.date.month}/${entry.date.year}";
    final Color entryColor = Color(entry.colorValue);

    return Container(
      width: 160,
      margin: const EdgeInsetsDirectional.only(end: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: entryColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: entryColor.withOpacity(0.3)),
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
              Text(entry.emoji, style: const TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Text(
              entry.text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
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
}