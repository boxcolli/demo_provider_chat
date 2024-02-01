import 'package:flutter/foundation.dart';

class MessageModel extends ChangeNotifier {
  var messages = <Message>[];

  int get length => messages.length;

  void addMessage(Message message) {
    messages.insert(0, message);
    messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    notifyListeners();
    print(messages.toString());
  }

  Message at(int index) => messages[index % length];
}

class Message {
  Message({
    required this.timestamp,
    required this.content,
    required this.name,
  });

  final DateTime timestamp;
  final String content;
  final String name;
}
