import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// پەیجی هەڵبژاردنی زمان (لەسەر وێنەکە دیزاین کراوە)
class _HomePageState extends State<HomePage> {
  // en, ar, ku, tr
  String _selected = 'en';

  final _langs = const [
    _Lang(
      code: 'en',
      label: 'English',
      flagUrl: 'https://flagcdn.com/w80/gb.png', // یەکگرتوو پەیوەندی HTTPS
      dir: TextDirection.ltr,
    ),
    _Lang(
      code: 'ar',
      label: 'Arabic',
      flagUrl: 'https://flagcdn.com/w80/iq.png',
      dir: TextDirection.rtl,
    ),
    _Lang(
      code: 'ku',
      label: 'Kurdish',
      // PNG لە ویکی‌میدیا (نە SVG بۆ ئەوەی پاکێج پێویست نەبێت)
      flagUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Flag_of_Kurdistan.svg/640px-Flag_of_Kurdistan.svg.png',
      dir: TextDirection.rtl,
    ),
    _Lang(
      code: 'tr',
      label: 'Turkish',
      flagUrl: 'https://flagcdn.com/w80/tr.png',
      dir: TextDirection.ltr,
    ),
  ];

  void _onDone() {
    final lang = _langs.firstWhere((l) => l.code == _selected);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DashboardScreen(langCode: lang.code, dir: lang.dir),
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
            const _TopWave(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text('choose Your',style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w400,
                            fontSize: 26,
                          ),),
                  Text('Preferred Language',
                      style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w800,
                            fontSize: 26,
                          ),),
                  const SizedBox(height: 28),

                  // لیستی زمانەکان
                  ..._langs.map((l) => Column(
                        children: [
                          _LangTile(
                            lang: l,
                            selected: _selected == l.code,
                            onTap: () => setState(() => _selected = l.code),
                          ),
                          const Divider(height: 1),
                        ],
                      )),

                  const Spacer(),
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
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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

// کاڕدەی دەرخستنی هەر هێڵێکی زمان
class _LangTile extends StatelessWidget {
  final _Lang lang;
  final bool selected;
  final VoidCallback onTap;

  const _LangTile({required this.lang, required this.selected, required this.onTap});

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
            // وێنەکە لە ئۆنلاینەوە
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                lang.flagUrl,
                width: 36,
                height: 24,
                fit: BoxFit.cover,
                // Placeholder بەبێ پاکێج
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
                      width: 12, height: 12,
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: selected
                  ? const Icon(Icons.check, key: ValueKey('y'), color: primary, size: 22)
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

/// موجەی سەرەوە
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
      ..quadraticBezierTo(
          size.width * 0.25, size.height * 0.20, size.width * 0.5, size.height * 0.32)
      ..quadraticBezierTo(
          size.width * 0.85, size.height * 0.48, size.width, size.height * 0.25)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// =================== DASHBOARD (٣ پەیج) ===================
class DashboardScreen extends StatefulWidget {
  final String langCode;
  final TextDirection dir;
  const DashboardScreen({super.key, required this.langCode, required this.dir});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = const [PageOne(), PageTwo(), PageThree()];
    final labels = const ['Home', 'Settings', 'Profile'];

    return Directionality(
      textDirection: widget.dir,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${labels[index]} (${widget.langCode.toUpperCase()})'),
        ),
        body: pages[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          selectedItemColor: const Color(0xFFFF5A36),
          onTap: (i) => setState(() => index = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// پەیجەکان
class PageOne extends StatelessWidget {
  const PageOne({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('📄 Page 1', style: TextStyle(fontSize: 20)));
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('⚙️ Page 2', style: TextStyle(fontSize: 20)));
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('👤 Page 3', style: TextStyle(fontSize: 20)));
}
