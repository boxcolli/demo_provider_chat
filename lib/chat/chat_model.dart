import 'package:flutter/foundation.dart';

class ChatModel extends ChangeNotifier {
  String _chatroom = '';

  String get chatroom => _chatroom;

  void setChatroom(String newChatroom) {
    _chatroom = newChatroom;
    notifyListeners();
  }
}
