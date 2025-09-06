// app_shell.dart
import 'package:flutter/material.dart';
import 'app_bottom_nav.dart';

// 👉 ئەمانە پەیجەکانەکەتن — بێگومان هەمووی لە پڕۆژەکەت هەن
import 'home.dart';         // پەیجی سەرەکی (هەمانەی هەنووکە)
    // پەیجی Profile

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  final _pages = const [
    HomeScreen(),          // 0
        // 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // هەموو پەیجەکان له‌ناو IndexedStack بۆ پاراستنی state
      body: IndexedStack(
        index: _index,
        children: _pages,
      ),

      // ⬇️ ناڤباڕی سراسرییەکەی ئێمه‌ (include)
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
