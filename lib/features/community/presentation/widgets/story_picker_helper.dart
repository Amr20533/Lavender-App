import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Helper class لاختيار الصور والفيديوهات للـ Stories

class StoryPickerHelper {
  static final ImagePicker _picker = ImagePicker();

  /// اختيار صورة من الكاميرا أو المعرض
  static Future<XFile?> pickImage(
      BuildContext context,
      ImageSource source,
      ) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);

      if (image == null) {
        return null; // المستخدم أغلق بدون اختيار
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم اختيار الصورة بنجاح')),
      );

      return image;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء اختيار الصورة')),
      );
      return null;
    }
  }

  /// اختيار فيديو من الكاميرا أو المعرض
  static Future<XFile?> pickVideo(
      BuildContext context,
      ImageSource source,
      ) async {
    try {
      final XFile? video = await _picker.pickVideo(source: source);

      if (video == null) {
        return null;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم اختيار الفيديو بنجاح')),
      );

      return video;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء اختيار الفيديو')),
      );
      return null;
    }
  }
}
