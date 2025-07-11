import 'package:flutter/material.dart';
import 'HomePage.dart'; // 경로가 맞는지 확인 (상대경로/절대경로 주의)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(), // HomePage 클래스 호출
    );
  }
}
