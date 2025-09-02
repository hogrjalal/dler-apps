import 'package:flutter/material.dart';
import 'login.dart'; // اگر ناوی پەیجی لۆگینت جیاوازە، لێرە بگۆڕە

class PasswordUpdatedSuccessScreen extends StatelessWidget {
  const PasswordUpdatedSuccessScreen({super.key});

  static const primary = Color(0xFFFF5A36);

  void _goLogin(BuildContext context) {
    // بگەڕێتەوە بۆ لۆگین و هەموو ستاگکە پاک بکە
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // گرادیەنتی خوارەوە وەک وێنەکە (کەمێک بەرزی شاشە پڕدەکات)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.42,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00FF5A36), primary], // سفید→نارنجی
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                children: [
                  // سەرەوە: بازنەی گەرانەوەی بچووک + لوگۆ
                  

                  const SizedBox(height: 120),

                  // وێنەی سەرکەوتن: asset یان online — هەردوو کاردەکەن
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      
                    ),
                    child: Image.asset(
                      'assets/img/done.png', // هەبێت بە ئاسێتت
                      height: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Icon(Icons.check_circle, size: 96, color: primary),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Your new password has been set. You can\nlogin to your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
const SizedBox(height: 44),
                  

                  // دوگمەی Login هاوشێوەی وێنەکە (نارنجی پڕ، Stadium + سایەی نەرمی)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _goLogin(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(45),
                        shape: const StadiumBorder(),
                        elevation: 3,
                        shadowColor: primary.withOpacity(.35),
                        textStyle: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
