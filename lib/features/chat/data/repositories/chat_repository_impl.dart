import 'package:dio/dio.dart';
import 'package:lavender/core/helpers/secure_storage_helper.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/networking/dio_helper.dart';
import 'package:lavender/features/chat/data/models/chat/inbox_response.dart';
import 'package:lavender/features/chat/data/models/chat/message_model.dart';
import '../../logic/repository_interface.dart';

class ChatRepositoryImpl implements ChatRepo {

  @override
  Future<InboxResponse> getChatInboxes() async{
    String? token = await SecureStorageHelper.getAccessToken();
    if (token == null) {
      throw Exception("No access token");
    }

    try {
      final response = await DioHelper.getData(
          url: ApiConstants.getInboxes,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
      );

      return InboxResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<List<MessageModel>> getChatMessages(int receiverId) async {
    String? token = await SecureStorageHelper.getAccessToken();

    try {
      // The URL now only requires the receiverId
      final response = await DioHelper.getData(
        url: '${ApiConstants.getMessages}/$receiverId/',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      return (response.data['data'] as List)
          .map((e) => MessageModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    }
  }

  @override
  Future<MessageModel> sendChatMessage(int receiverId, String message) async {
    String? token = await SecureStorageHelper.getAccessToken();
    try {
      final response = await DioHelper.postData(
        url: ApiConstants.sendMessage,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        data: {
          'receiver': receiverId,
          'message': message,
        },
      );

      return MessageModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw Exception("Failed to send message: ${e.message}");
    } catch (e) {
      throw Exception("Send failed: $e");
    }
  }
}
