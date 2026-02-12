import 'package:hive_flutter/hive_flutter.dart';
import 'package:lavender/features/programs/data/models/diary_entry.dart';

class DiaryRepository {
  static const String boxName = 'diaryBox';

  static Future<void> saveEntry(DiaryEntry entry) async {
    final box = Hive.box(boxName);
    await box.put(entry.id, entry.toMap());
  }

  static List<DiaryEntry> getAllEntries() {
    final box = Hive.box(boxName);
    final List<DiaryEntry> entries =
    box.values
        .map((e) => DiaryEntry.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    // Sort by date descending (newest first)
    entries.sort((a, b) => b.date.compareTo(a.date));
    return entries;
  }

  static Future<void> deleteEntry(String id) async {
    final box = Hive.box(boxName);
    await box.delete(id);
  }
}