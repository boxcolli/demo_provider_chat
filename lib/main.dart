import 'dart:io';

import 'package:demo_provider_chat/chat/chat_model.dart';
import 'package:demo_provider_chat/chat/chat_page.dart';
import 'package:demo_provider_chat/login/login_page.dart';
import 'package:demo_provider_chat/login/user_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
  }

  runApp(const MainApp());
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/login',
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => ChatPage(),
      ),
    ],
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(create: (context) => UserModel()),
        ChangeNotifierProvider<ChatModel>(create: (_) => ChatModel()),
      ],
      child: MaterialApp.router(
        title: 'Provider Chat Demo',
        routerConfig: router(),
      ),
    );
  }
}
