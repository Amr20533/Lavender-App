import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:lavender/features/community/data/models/comment.dart';
import 'package:lavender/features/community/data/models/post.dart';
import 'package:lavender/features/community/data/repositories/community_repo_impl.dart';
import 'package:lavender/features/community/presentation/cubit/community_states.dart';
import 'package:lavender/features/community/presentation/cubit/create_post_states.dart';

class CreatePostCubit extends Cubit<CreatePostStates> {
  final CommunityRepositoryImpl repository;
  TextEditingController captionController = TextEditingController();

  CreatePostCubit(this.repository) : super(AddPostInitial());

  Future<Post?> createPost() async {
    final caption = captionController.text.trim();
    if (caption.isEmpty) return null;

    emit(AddPostLoading());

    try {
      final response = await repository.addPost(caption);
      captionController.clear();
      emit(AddPostSuccess());
      return response.data;
    } catch (e) {
      emit(AddPostError(e.toString()));
      return null;
    }
  }
}
