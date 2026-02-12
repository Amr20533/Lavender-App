import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostBottomSheet extends StatelessWidget {
  final Function(ImageSource) onPickImage;

  const AddPostBottomSheet({
    super.key,
    required this.onPickImage,
  });

  /// عرض الـ Bottom Sheet
  static void show(
      BuildContext context, {
        required Function(ImageSource) onPickImage,
      }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AddPostBottomSheet(
        onPickImage: onPickImage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt, color: Colors.blue),
            title: Text('التقاط صورة'),
            onTap: () {
              Navigator.pop(context);
              onPickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library, color: Colors.blue),
            title: Text('اختيار من المعرض'),
            onTap: () {
              Navigator.pop(context);
              onPickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
