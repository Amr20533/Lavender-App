import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Helper class لاختيار الصور والفيديوهات للـ Stories
class StoryPickerHelper {
  /// اختيار صورة من الكاميرا أو المعرض
  static Future<void> pickImage(
    BuildContext context,
    ImageSource source,
  ) async {
    // TODO: استخدام image_picker package
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: source);
    
    // if (image != null) {
    //   // هنا يتم رفع الصورة للـ Backend
    //   // وبعدين إضافتها للـ Stories
    // }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('جاري إضافة الصورة... (قريباً)')),
    );
  }

  /// اختيار فيديو من الكاميرا أو المعرض
  static Future<void> pickVideo(
    BuildContext context,
    ImageSource source,
  ) async {
    // TODO: استخدام image_picker package
    // final ImagePicker picker = ImagePicker();
    // final XFile? video = await picker.pickVideo(source: source);
    
    // if (video != null) {
    //   // هنا يتم رفع الفيديو للـ Backend
    // }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('جاري إضافة الفيديو... (قريباً)')),
    );
  }
}
