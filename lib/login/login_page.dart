import 'package:demo_provider_chat/chat/chat_model.dart';
import 'package:demo_provider_chat/login/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    super.key,
  });

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sole Chat', style: theme.textTheme.displaySmall),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Your name'),
              ),
              TextField(
                controller: _roomController,
                decoration: const InputDecoration(hintText: 'Chat room'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    var name = _nameController.text;
                    var room = _roomController.text;
                    if (name == "" || room == "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Please input something on both textfield.'),
                      ));
                      return;
                    }
                    context.read<UserModel>().setUsername(name);
                    context.read<ChatModel>().setChatroom(room);
                    context.push('/chat');
                  },
                  child: const Text('ENTER')),
            ],
          ),
        ),
      ),
    );
  }
}
