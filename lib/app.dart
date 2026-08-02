import 'package:flutter/material.dart';
import 'features/auth/login_page.dart';

class StudyAIApp extends StatelessWidget {
  const StudyAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "StudyAI",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: const LoginPage(),
    );
  }
}
