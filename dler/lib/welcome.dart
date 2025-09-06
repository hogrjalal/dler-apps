import 'package:flutter/material.dart';
import 'login.dart'; 
import 'forgotpassword.dart';
import 'register.dart';
import 'language.dart';
class WelcomeScreen extends StatelessWidget {
  final String langCode;
  final TextDirection dir;
  const WelcomeScreen({super.key, required this.langCode, required this.dir});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFFFF5A36);

    return Directionality(
      textDirection: dir,
      child: Scaffold(
        body: Stack(
          children: [
            // Background gradient: white -> orange
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color(0xFFFF5A36)],
                  stops: [0.35, 1.0],
                ),
              ),
              child: SizedBox.expand(),
            ),

            // Content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // ناوەڕاست
                  children: [
                    const SizedBox(height: 36),
                    // ===== Back button (top-left) =====
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primary,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
  icon: const Icon(
    Icons.arrow_back,
    color: Colors.white,
    size: 32, // ⬅️ قەبارەی قووڵتر
    shadows: [
      Shadow(
        color: Color.fromARGB(255, 255, 255, 255),
        offset: Offset(1, 1),
        blurRadius: 2,
      ),
    ],
  ),
  onPressed: () {
    Navigator.pop(context);
  },
),

                      ),
                    ),

                    const Spacer(flex: 2),

                    // ===== Title & subtitle (center) =====
                    const Text(
                      'Welcome!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        height: 1.1,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Choose one option to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(243, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const Spacer(flex: 3),

                    // ===== Login (filled) =====
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                        // لە سەرەوەی فایلەکە زیاد بکە

// ...
Navigator.push(context,
  MaterialPageRoute(builder: (_) => const LoginScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(44),
                          shape: const StadiumBorder(),
                          elevation: 0,
                        ),
                        child: const Text('Login',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ===== Register (white bg + primary border/text) =====
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context,
  MaterialPageRoute(builder: (_) => const RegisterScreen()));
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: primary,
                          side: const BorderSide(color: primary, width: 1.4),
                          minimumSize: const Size.fromHeight(44),
                          shape: const StadiumBorder(),
                          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        child: const Text('Register'),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ===== Forgot password =====
                    TextButton(
                       onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
        );
      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black87,
                      ),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                         
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder pages (بە پەیجەکانی خۆت بگۆڕە)
class _LoginPlaceholder extends StatelessWidget {
  const _LoginPlaceholder({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
        
        body: Center(child: Text('Login Screen')),
      );
}

class _RegisterPlaceholder extends StatelessWidget {
  const _RegisterPlaceholder({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
        
        body: Center(child: Text('Register Screen')),
      );
}
