import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lavender/core/themes/app_colors.dart';

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
        SnackBar(
          content: Text(
            'تم اختيار الصورة بنجاح',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryColorLavenderLangAndText,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white.withOpacity(0.2),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: AppColors.primaryColorLavenderLangAndText.withOpacity(0.3),
            ),
          ),
        ),
      );

      return image;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'حدث خطأ أثناء اختيار الصورة',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white.withOpacity(0.2),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.red.withOpacity(0.3)),
          ),
        ),
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
        SnackBar(
          content: Text(
            'تم اختيار الفيديو بنجاح',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryColorLavenderLangAndText,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white.withOpacity(0.2),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: AppColors.primaryColorLavenderLangAndText.withOpacity(0.3),
            ),
          ),
        ),
      );

      return video;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'حدث خطأ أثناء اختيار الفيديو',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white.withOpacity(0.2),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.red.withOpacity(0.3)),
          ),
        ),
      );
      return null;
    }
  }
}
