import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Bottom Sheet لإضافة Story جديدة
class AddStoryBottomSheet extends StatelessWidget {
  final Function(ImageSource) onPickImage;
  final Function(ImageSource) onPickVideo;

  const AddStoryBottomSheet({
    Key? key,
    required this.onPickImage,
    required this.onPickVideo,
  }) : super(key: key);

  /// عرض الـ Bottom Sheet
  static void show(
    BuildContext context, {
    required Function(ImageSource) onPickImage,
    required Function(ImageSource) onPickVideo,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AddStoryBottomSheet(
        onPickImage: onPickImage,
        onPickVideo: onPickVideo,
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
          ListTile(
            leading: Icon(Icons.videocam, color: Colors.blue),
            title: Text('تصوير فيديو'),
            onTap: () {
              Navigator.pop(context);
              onPickVideo(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.video_library, color: Colors.blue),
            title: Text('اختيار فيديو'),
            onTap: () {
              Navigator.pop(context);
              onPickVideo(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
