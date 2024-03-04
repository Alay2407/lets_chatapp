import 'package:lets_chatapp/data/Model/chat/getAll_chat.dart';

abstract class GetAllChatRepository{
  Future<GetAllChat> getAllChat();
}