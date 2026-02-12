import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:lavender/features/chat/presentation/cubit/inbox_states.dart';

import '../../../../core/helpers/secure_storage_helper.dart' show SecureStorageHelper;

class InboxCubit extends Cubit<InboxState> {
  final ChatRepositoryImpl chatRepo;

  InboxCubit(this.chatRepo) : super(InboxInitial());

  Future<void> fetchInboxes() async {
    emit(InboxLoading());
    try {
      final response = await chatRepo.getChatInboxes();
      final idString = await SecureStorageHelper.getCurrentUserId();
      final int currentUserId = int.parse(idString ?? '0');

      if (response.data.isEmpty) {
        emit(InboxEmpty());
      } else {
        emit(InboxSuccess(response.data, currentUserId));
      }
    } catch (e) {
      emit(InboxError(e.toString()));
    }
  }
}