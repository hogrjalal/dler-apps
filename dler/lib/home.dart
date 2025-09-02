import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'salealuminum.dart';
import 'createdoor.dart';
import 'saleglass.dart';

void main() {
  runApp(const DlerApp());
}

class DlerApp extends StatelessWidget {
  const DlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DLER Company',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bg,
        fontFamily: 'Roboto',
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.cardText,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.15,
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class GradientBanner extends StatelessWidget {
  const GradientBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/img/gradient_banner.png",
      width: double.infinity, // پر دەکات بە پەنی شاشە
      height: 132,
      fit: BoxFit.cover,
    );
  }
}

/// رنگەکان
class AppColors {
  static const coralDark = Color(0xFFFF5A36);
  static const coralMid = Color(0xFFFF7E61);
  static const coralSoft = Color(0xFFFFB59F);

  static const bg = Color(0xFFFFF7F4);
  static const card = Color(0xFFF7F1EF);
  static const cardText = Colors.black87;

  static const navGradStart = Color(0xFFFFB49E);
  static const navGradEnd   = Color(0xFFFFB49E);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const GradientBanner(),

          // ناوەڕۆکی ناوەراست — کۆمپاکت و بەبێ سکرۆل
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 19, 16, 96),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 24),
                  const _Logo(),
                  const SizedBox(height: 10),

                  // ⬇️ بەتنی تەکست بەجای کارت
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(165, 0, 0, 0),
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Createdoorscreen()),
        );}, // لەوانەیە دواتر ڕوتینگ زیاد بکەیت
                      child: Column(
                        children: [
                          SizedBox(
                            height: 66,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset('assets/img/create.png'),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text('Creating Doors&Windows'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(165, 0, 0, 0),
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Salealuminumscreen()),
        );},
                      child: Column(
                        children: [
                          SizedBox(
                            height: 66,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset('assets/img/alm.png'),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text('Selling Aluminum'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(165, 0, 0, 0),
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const saleglassscreen()),
        );},
                      child: Column(
                        children: [
                          SizedBox(
                            height: 66,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset('assets/img/glass.png'),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text('Selling Glass'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // فوتەر — هەمانە، هیچ دەسکاری نەکراوە
          Align(
            alignment: Alignment.bottomCenter,
            child: _BottomNavBar(
              currentIndex: currentIndex,
              onTap: (i) => setState(() => currentIndex = i),
            ),
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/img/logo.png',
        height: 120,
      ),
    );
  }
}

/* ======================= FOOTER (UNCHANGED) ======================= */

class _BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const bubbleSize = 6.0;
    const notchRadius = 38.0;
    const notchdynamic = notchRadius * 0.60;
    const hPad = 10.0;
    const vPad = 8.0;

    final icons = <IconData>[
      Icons.home_rounded,
      Icons.receipt_long_rounded,
      Icons.shopping_cart_rounded,
      Icons.notifications_rounded,
      Icons.person_rounded,
    ];
    final labels = <String>['Home', 'Orders', 'Cart', 'Notification', 'Profile'];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: SizedBox(
          height: 82,
          width: double.infinity,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth;
              const slots = 5;
              final slotWidth = (barWidth - (hPad * 2)) / slots;

              double centerX(int index) =>
                  hPad + slotWidth * index + slotWidth / 2;

              final cx = centerX(currentIndex);

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Background bar with carved notch
                  Positioned.fill(
                    child: AnimatedCustomPaint(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOutCubic,
                      painter: _BarPainter(
                        notchCenterX: cx,
                        notchRadius: notchRadius,
                      ),
                    ),
                  ),

                  // Items
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: hPad, vertical: vPad),
                      child: Row(
                        children: List.generate(slots, (i) {
                          final isActive = currentIndex == i;
                          return Expanded(
                            child: _NavItem(
                              icon: icons[i],
                              label: labels[i],
                              isActive: isActive,
                              onTap: () => onTap(i),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  // Floating bubble on notch
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutBack,
                    left: cx - bubbleSize / 0.35,
                    top: -bubbleSize * 0.10,
                    child: _FloatingBubble(
                      child: Icon(
                        icons[currentIndex],
                        color: const Color.fromARGB(255, 255, 255, 255),
                        size: 26,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BarPainter extends CustomPainter {
  final double notchCenterX;
  final double notchRadius;

  _BarPainter({
    required this.notchCenterX,
    required this.notchRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final shader = const LinearGradient(
      colors: [Color.fromARGB(255, 255, 181, 158), Color.fromARGB(255, 255, 181, 158)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Offset.zero & size);

    final rectPath = Path()
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(1, 5, size.width, size.height),
        topLeft: const Radius.circular(24),
        topRight: const Radius.circular(24),
      ));

    final notchCenter = Offset(notchCenterX, 0.5);
    final notchPath =
        Path()..addOval(Rect.fromCircle(center: notchCenter, radius: notchRadius));

    final carved = Path.combine(PathOperation.difference, rectPath, notchPath);

    final paint = Paint()..shader = shader;
    canvas.drawPath(carved, paint);
    canvas.drawShadow(carved, const Color.fromARGB(0, 0, 0, 0), 12, false);
  }

  @override
  bool shouldRepaint(covariant _BarPainter oldDelegate) {
    return oldDelegate.notchCenterX != notchCenterX ||
        oldDelegate.notchRadius != notchRadius;
  }
}

class AnimatedCustomPaint extends ImplicitlyAnimatedWidget {
  final CustomPainter painter;

  const AnimatedCustomPaint({
    super.key,
    required this.painter,
    required Duration duration,
    Curve curve = Curves.linear,
  }) : super(duration: duration, curve: curve);

  @override
  ImplicitlyAnimatedWidgetState<AnimatedCustomPaint> createState() =>
      _AnimatedCustomPaintState();
}

class _AnimatedCustomPaintState
    extends ImplicitlyAnimatedWidgetState<AnimatedCustomPaint> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: widget.painter,
      size: Size.infinite,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {}
}

class _FloatingBubble extends StatelessWidget {
  final Widget child;
  const _FloatingBubble({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 148, 124),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 20,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: const Color.fromARGB(255, 250, 72, 2).withOpacity(isActive ? 1 : 0.9),
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: isActive ? 0.0 : 1.0,
            child: Icon(icon, size: 24, color: const Color.fromARGB(255, 250, 72, 2)),
          ),
          const SizedBox(height: 2),
          Text(label, textAlign: TextAlign.center, style: labelStyle),
        ],
      ),
    );
  }
}
