import 'package:flutter/material.dart';
import 'otp_verification.dart';

class ForgotViaEmailScreen extends StatefulWidget {
  const ForgotViaEmailScreen({super.key});

  @override
  State<ForgotViaEmailScreen> createState() => _ForgotViaEmailScreenState();
}

class _ForgotViaEmailScreenState extends State<ForgotViaEmailScreen> {
  static const primary = Color(0xFFFF5A36);
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _send() {
    final e = _email.text.trim();
    if (e.isEmpty || !_isValidEmail(e)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email')),
      );
      return;
    }

    // TODO: لێرە بانگەوازی API ـەکەت بۆ ناردنی OTP بکە

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpVerificationScreen(
          via: 'Email',
          maskedTo: _maskEmail(e),
        ),
      ),
    );
  }

  bool _isValidEmail(String v) {
    final r = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return r.hasMatch(v);
  }

  String _maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final name = parts[0];
    final domain = parts[1];
    final shown = name.isNotEmpty ? name[0] : '';
    return '$shown***@${domain}';
  }

  @override
  Widget build(BuildContext context) {
    final cardHeight = MediaQuery.of(context).size.height * 0.68; // ⬅️ کارت بچووکتر

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            children: [
              const SizedBox(height: 34),
              // ⬆️ سەرەوە: بازنە + لوگۆ
              Row(
                children: [
                  const SizedBox(width: 18),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(color: primary, shape: BoxShape.circle),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.close, color: Colors.white, size: 18),
                      onPressed: () => Navigator.pop(context),
                      tooltip: 'Close',
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/img/logo.png',
                    height: 48,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const SizedBox(height: 48),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 54),

              // 🟧 کارت گرادیەنت بچووکتر و دوور لە خوارەوە
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Container(
                    height: cardHeight,
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [primary.withOpacity(.35), primary],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.06),
                          blurRadius: 14,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Forget Password',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 46),

                        const Text(
                          'Enter your email address to recover\npassword',
                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 20),

                        // 📨 ئینپوتی ئیمەیڵ
                        TextField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'example@mail.com',
                            hintStyle: const TextStyle(color: Color.fromARGB(255, 89, 89, 89)),
                            filled: true,
                            fillColor: const Color(0x0FFFFFFF),
                            prefixIcon: const Icon(Icons.email_outlined, color: primary),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.black45, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: primary, width: 1.4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 80),

                        

                        // دوکمەی Send OTP
                        Center(
                          child: SizedBox(
                            width: 280,
                            child: OutlinedButton(
                              onPressed: _send,
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: primary,
                                side: const BorderSide(color: primary, width: 1.6),
                                minimumSize: const Size.fromHeight(48),
                                shape: const StadiumBorder(),
                                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              child: const Text('Send OTP'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
