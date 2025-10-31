/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_states.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class UserInfoProfile extends StatefulWidget {
  const UserInfoProfile({super.key});

  @override
  State<UserInfoProfile> createState() => _UserInfoProfileState();
}

class _UserInfoProfileState extends State<UserInfoProfile> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  // ✅ الدالة اللي بتختار الصورة (من كاميرا أو معرض)
  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      final status = await Permission.mediaLibrary.request();
      if (!status.isGranted) return;
    } else {
      final status = await Permission.mediaLibrary.request();
      if (!status.isGranted) return;
    }

    final XFile? image = await _picker.pickImage(source: source, imageQuality: 80);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  // ✅ الديالوج لاختيار المصدر
  void _showPickOptionsDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "اختر مصدر الصورة",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("الكاميرا"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("المعرض"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 60),
      child: BlocBuilder<CurrentUserCubit, CurrentUserStates>(
        builder: (context, state) {
          if (state is CurrentUserProfileLoading) {
            return const Center(
              
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is CurrentUserProfileLoaded) {
            final user = state.currentUserInfoResponse.profile.user;
            final profile = state.currentUserInfoResponse.profile.profilePic;
            final name = "${user.firstName} ${user.lastName}".trim();

            return Column(   
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _showPickOptionsDialog,
                  child: Container(
                    width: 90,
                    height: 90,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      gradient: AppColors.circleGradient,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: _pickedImage != null
                          ? Image.file(_pickedImage!, fit: BoxFit.cover)
                          : CustomCachedNetworkImage(
                              imageUrl: "${ApiConstants.imagePath}$profile",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AlexText(
                  text: name,
                  color: Colors.white,
                ),
              ],
            );
          } else if (state is CurrentUserProfileError) {
            return const Text("Error loading user", style: TextStyle(color: Colors.white));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}*/