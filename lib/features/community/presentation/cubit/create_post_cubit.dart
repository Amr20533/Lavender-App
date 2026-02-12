import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lavender/features/community/data/models/comment.dart';
import 'package:lavender/features/community/data/models/post.dart';
import 'package:lavender/features/community/data/repositories/community_repo_impl.dart';
import 'package:lavender/features/community/presentation/cubit/community_states.dart';
import 'package:lavender/features/community/presentation/cubit/create_post_states.dart';
import 'dart:io';

class CreatePostCubit extends Cubit<CreatePostStates> {
  final CommunityRepositoryImpl repository;
  TextEditingController captionController = TextEditingController();
  File? selectedImage; // Add this
  final ImagePicker _picker = ImagePicker();

  CreatePostCubit(this.repository) : super(AddPostInitial());

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80, // Reduces size for faster uploads
      );

      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        emit(ImagePickedState());
      }
    } catch (e) {
      emit(AddPostError("Failed to pick image: $e"));
    }
  }  void removeImage() {
    selectedImage = null;
    emit(ImageRemovedState());
  }

  Future<Post?> createPost(File? selectedImage) async {
    final caption = captionController.text.trim();

    // Check if at least one field is filled
    if (caption.isEmpty && selectedImage == null) return null;

    emit(AddPostLoading());
    try {
      // Pass both to repository
      final response = await repository.addPost(caption, selectedImage);

      captionController.clear();
      selectedImage = null;

      emit(AddPostSuccess());
      return response.data;
    } catch (e) {
      emit(AddPostError(e.toString()));
      return null;
    }
  }
}
