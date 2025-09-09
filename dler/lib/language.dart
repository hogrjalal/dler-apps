import 'package:flutter/material.dart';
import 'welcome.dart'; // دڵنیابە ئەم فایلە هەیە و WelcomeScreen تێدایە

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class GradientBanner extends StatelessWidget {
  const GradientBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/img/gradient_banner.png",
      width: double.infinity,
      height: 132,
      fit: BoxFit.cover,
    );
  }
}

/// پەیجی هەڵبژاردنی زمان
class _HomePageState extends State<HomePage> {
  // en, ar, ku, tr
  String _selected = 'en';

  final _langs = const [
    _Lang(
      code: 'en',
      label: 'English',
      flagUrl: 'https://flagcdn.com/w80/gb.png', // 🇬🇧
      dir: TextDirection.ltr,
    ),
    _Lang(
      code: 'ar',
      label: 'Arabic',
      flagUrl: 'https://flagcdn.com/w80/iq.png', // 🇮🇶
      dir: TextDirection.rtl,
    ),
    _Lang(
      code: 'ku',
      label: 'Kurdish',
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Flag_of_Kurdistan.svg/640px-Flag_of_Kurdistan.svg.png',
      dir: TextDirection.rtl,
    ),
    _Lang(
      code: 'tr',
      label: 'Turkish',
      flagUrl: 'https://flagcdn.com/w80/tr.png', // 🇹🇷
      dir: TextDirection.ltr,
    ),
  ];

  void _onDone() {
    final lang = _langs.firstWhere((l) => l.code == _selected);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => WelcomeScreen(langCode: lang.code, dir: lang.dir),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFFFF5A36);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const GradientBanner(), // موجەی سەرەوە
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),

                  // سەردێڕ
                  const Text(
                    'choose Your',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w400,
                      fontSize: 32,
                    ),
                  ),
                  const Text(
                    'Preferred Language',
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 32,
                    ),
                  ),

                  const SizedBox(height: 48),

                  // لیستی زمانەکان + بەرزی نێوانیان
                  ..._langs.map((l) => Column(
                        children: [
                          _LangTile(
                            lang: l,
                            selected: _selected == l.code,
                            onTap: () => setState(() => _selected = l.code),
                          ),
                          const SizedBox(height: 50), // ← بەرزی زیادکرا
                        ],
                      )),

                  const Spacer(), // ← بەجێی SizedBox(208) ئەوە بەکاردهێنم بۆ فاصلەی خوار

                  // دوکمەی Done
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onDone,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(52),
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                        elevation: 0,
                      ),
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ــــــــــــــــــ Widgets & Helpers ــــــــــــــــــ

// هێڵی هەر زمانێک
class _LangTile extends StatelessWidget {
  final _Lang lang;
  final bool selected;
  final VoidCallback onTap;

  const _LangTile({
    required this.lang,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFFFF5A36);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            // وێنەی ئاڵا
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                lang.flagUrl,
                width: 58,
                height: 38,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    width: 36,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(strokeWidth: 1.6),
                    ),
                  );
                },
                errorBuilder: (context, error, stack) => Container(
                  width: 36,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.flag_outlined, size: 16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                lang.label,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: selected
                  ? const Icon(Icons.check,
                      key: ValueKey('y'), color: primary, size: 22)
                  : const SizedBox.shrink(key: ValueKey('n')),
            ),
          ],
        ),
      ),
    );
  }
}

class _Lang {
  final String code;
  final String label;
  final String flagUrl;
  final TextDirection dir;

  const _Lang({
    required this.code,
    required this.label,
    required this.flagUrl,
    required this.dir,
  });
}

/// موجەی سەرەوە (نارنجی) ـ بەکارنەهاتوو ئەمجاگرە
class _TopWave extends StatelessWidget {
  const _TopWave();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: double.infinity,
      child: CustomPaint(painter: _WavePainter()),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFFF5A36);
    final path = Path()
      ..lineTo(0, size.height * 0.45)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.20,
          size.width * 0.5, size.height * 0.32)
      ..quadraticBezierTo(size.width * 0.85, size.height * 0.48,
          size.width, size.height * 0.25)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
