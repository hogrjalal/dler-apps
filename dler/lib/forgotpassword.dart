import 'package:flutter/material.dart';
import 'forgot_via_email.dart';
import 'forgot_via_whatsapp.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  static const primary = Color(0xFFFF5A36);
  int _selected = 0; // 0 = Email, 1 = Whatsapp

  void _pick(int i) {
  if (_selected == i) return;
  setState(() => _selected = i);

  // ڕاستەوخۆ ڕێنوێنە بۆ پەڕەی گونجاو
  if (i == 0) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ForgotViaEmailScreen()),
    );
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ForgotViaWhatsappScreen()),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          // موجەی خوارەوە
          const Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(height: 160, width: double.infinity, child: _BottomWave()),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 18),
                  // سەطرێ سەرەوە: دوگمەی داخستن + لوگۆ
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
                        height: 36,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const SizedBox(height: 36),
                      ),
                      const Spacer(),
                      const SizedBox(width: 48),
                    ],
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Select a method to reset\nyour password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      height: 1.25,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // وێنەی OTP (ئۆنلاین)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                     
                    ),
                    child:  Image.asset(
                        'assets/img/otp.png',
                      height: 160,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 120, color: Colors.black26),
                    ),
                  ),

                  const SizedBox(height: 14),
                  const Text(
                    'Send OTP via',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ✅ Segmented control: Email / Whatsapp (بە ئەنیمەیشن)
                  _OtpMethodSelector(
                    selected: _selected,
                    onChanged: _pick,
                  ),

                  const Spacer(),

                  // (ئارەزوومەندانە) دوکمەی Continue/Send
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ————————— Segmented Widget —————————
/// یەک کارتەی یەکەوە (Email/Whatsapp) کە باگرەوندی پرایمەری بە ئەنیمەیشن
/// دەچێتە ژێر هەڵبژاردەی دیاری‌کراو.
class _OtpMethodSelector extends StatelessWidget {
  final int selected; // 0=email, 1=whatsapp
  final ValueChanged<int> onChanged;
  const _OtpMethodSelector({required this.selected, required this.onChanged});

  static const primary = _ForgotPasswordScreenState.primary;

  @override
  Widget build(BuildContext context) {
    const double h = 48;
    const double r = 14;

    return SizedBox(
      height: h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(r),
        child: Stack(
          children: [
            // پشتەوەی سەرهێڵ
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(26, 2, 2, 2),
                border: Border.all(color: const Color.fromARGB(30, 0, 0, 0), width: 1.2),
                borderRadius: BorderRadius.circular(r),
              ),
            ),
            // هایڵایتێکی تەواو بە ئەنیمەیشن (نیمە قەبارە)
            AnimatedAlign(
              alignment: selected == 0 ? Alignment.centerLeft : Alignment.centerRight,
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                heightFactor: 1.0,
                child: Container(
                  margin: const EdgeInsets.all(2), // بۆ نیشاندانی بۆردەرەکە
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(r - 4),
                  ),
                ),
              ),
            ),
            // لایەری کلیک و شتێنەکان
            Row(
              children: [
                _segItem(
                  context,
                  icon: Icons.email_outlined,
                  label: 'Email',
                  isActive: selected == 0,
                  onTap: () => onChanged(0),
                ),
                _segItem(
                  context,
                  icon: Icons.chat_bubble_outline, // واتس‌ئاپ (بدیلی icons)
                  label: 'Whatsapp',
                  isActive: selected == 1,
                  onTap: () => onChanged(1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded _segItem(BuildContext context,
      {required IconData icon,
      required String label,
      required bool isActive,
      required VoidCallback onTap}) {
    final Color fg = isActive ? Colors.white : Colors.black87;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18, color: fg),
                const SizedBox(width: 6),
                Text(label,
                    style: TextStyle(fontWeight: FontWeight.w800, color: fg)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/// ————————— موجەی خوارەوە —————————
class _BottomWave extends StatelessWidget {
  const _BottomWave();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BottomWavePainter(),
      size: const Size(double.infinity as double, 160),
    );
  }
}

class _BottomWavePainter extends CustomPainter {
  static const primary = Color(0xFFFF5A36);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = primary;
    final path = Path()
      ..moveTo(0, size.height * 0.35)
      ..quadraticBezierTo(
          size.width * 0.25, size.height * 0.10, size.width * 0.5, size.height * 0.22)
      ..quadraticBezierTo(
          size.width * 0.80, size.height * 0.42, size.width, size.height * 0.20)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
