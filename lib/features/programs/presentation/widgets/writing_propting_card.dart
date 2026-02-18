import 'package:flutter/material.dart';
import 'package:lavender/features/programs/presentation/write_entry_page.dart';

class WritingPromptCard extends StatelessWidget {
  final Map<String, dynamic> prompt;
  final VoidCallback onEntrySaved;

  const WritingPromptCard({
    super.key,
    required this.prompt,
    required this.onEntrySaved,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WriteEntryPage(initialText: prompt['prompt']),
          ),
        );
        // استدعاء التحديث بعد العودة من صفحة الكتابة
        onEntrySaved();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (prompt['color'] as Color).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                prompt['icon'],
                color: (prompt['color'] as Color).withOpacity(0.8),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prompt['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    prompt['subtitle'],
                    style: const TextStyle(fontSize: 13, color: Color(0xFF888888)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_back_ios_new, size: 14, color: Color(0xFFCCCCCC)),
          ],
        ),
      ),
    );
  }
}