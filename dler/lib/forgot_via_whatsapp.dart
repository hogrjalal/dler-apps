import 'package:flutter/material.dart';
import 'otp_verification.dart';
class ForgotViaWhatsappScreen extends StatefulWidget {
  const ForgotViaWhatsappScreen({super.key});

  @override
  State<ForgotViaWhatsappScreen> createState() => _ForgotViaWhatsappScreenState();
}

class _ForgotViaWhatsappScreenState extends State<ForgotViaWhatsappScreen> {
  static const primary = Color(0xFFFF5A36);
  final _phone = TextEditingController();

  void _send() {
    final p = _phone.text.trim();
    if (p.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your mobile number')),
      );
      return;
    }
    // TODO: ناردنی OTP بە واتس‌ئاپ
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP sent to $p via WhatsApp')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
         
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
             
            children: [
               const SizedBox(height: 30),
              // سەرەوە: بازنەی داخستن + لوگۆ ناوەڕاست
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 20),
                      onPressed: () => Navigator.pop(context),
                      tooltip: 'Close',
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/img/logo.png',
                    height: 48,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const SizedBox(height: 38),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 14),

              Expanded(
                child: Container(
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
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),

                      const Text(
                        'Enter your mobile number to recover\npassword',
                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 30),

                      // خانەی ژمارەی مۆبایل
                      TextField(
                        decoration: InputDecoration(
  hintText: '(+964) 750 000 00 00', // یان ئیمەیڵ
  hintStyle: const TextStyle(color: Color(0xFF8A8A8A)),
  filled: true,
  fillColor: const Color(0x0FFFFFFF),
  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12), // 👈 vertical کەم کرا
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.black45, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: _ForgotViaWhatsappScreenState.primary, width: 1.4),
  ),
),

                      ),

                      const SizedBox(height: 38),

                      // ✅ دوکمە لە جێی خۆی
                      Center(
                        child: SizedBox(
                          width: 220,
child: OutlinedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const OtpVerificationScreen(
          via: 'WhatsApp number',          // یا 'Email'
          maskedTo: '+964 750 ...', 
        ),
      ),
    );
  },
  style: OutlinedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: primary,
    side: const BorderSide(color: primary, width: 1.6),
    minimumSize: const Size.fromHeight(48),
    shape: const StadiumBorder(),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
  ),
  child: const Text('Send OTP'),
),
                        ),
                      ),

                      const Spacer(),
                    ],
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
