import 'package:demo_provider_chat/chat/chat_model.dart';
import 'package:demo_provider_chat/chat/message_model.dart';
import 'package:demo_provider_chat/login/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  ChatPage({
    super.key,
  });

  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var room = context.select<ChatModel, String>((chat) => chat.chatroom);

    return Scaffold(
      appBar: AppBar(
        title: Text(room),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => MessageModel(),
        child: Column(
          children: [
            Expanded(child: MessageList(scrollController: _scrollController)),
            const SizedBox(height: 8),
            Center(
              child: InputContainer(
                messageController: _messageController,
                scrollController: _scrollController,
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var myname = context.select<UserModel, String>((user) => user.username);
    var messages = context.watch<MessageModel>();

    return Container(
      color: Colors.blue.shade50,
      child: Align(
        alignment: Alignment.topCenter,
        child: ListView.separated(
          shrinkWrap: true,
          reverse: true,
          controller: scrollController,
          itemBuilder: (context, index) {
            var message = messages.at(index);
            var isMe = message.name == myname;
            var widgets = <Widget>[
              Icon(
                Icons.person,
                color: isMe ? theme.primaryColor : theme.secondaryHeaderColor,
                size: 50,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message.content,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: LimitedBox(
                maxHeight: 48,
                child: Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: isMe ? widgets.reversed.toList() : widgets,
                ),
              ),
            );
          },
          itemCount: messages.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
        ),
      ),
    );
  }
}

class InputContainer extends StatelessWidget {
  const InputContainer({
    super.key,
    required this.messageController,
    required this.scrollController,
  });

  final TextEditingController messageController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    var username = context.select<UserModel, String>((user) => user.username);
    var messages = context.read<MessageModel>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.amber.shade400,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      width: 400,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                var message = messageController.text;
                if (message == "") {
                  return;
                }

                messages.addMessage(Message(
                  content: messageController.text,
                  name: username,
                  timestamp: DateTime.now(),
                ));

                messageController.text = '';

                scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              child: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
