import 'package:flutter/material.dart';

import 'createdoor.dart';
import 'saleglass.dart';
import 'app_shell.dart';
import 'sell_almnium.dart';
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
      // ⬅️ شێڵی سراسری کە ناڤباڕی جیاواز تێدایە
      home: const AppShell(),
    );
  }
}

/// ئەمانە هەمان تعریفەکانی پێشترت — تەنیا دڵنیا بەرەوە هەمان شوێنن




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

/// رنگەکان
class AppColors {
  static const coralDark = Color(0xFFFF5A36);
  static const coralMid = Color(0xFFFF7E61);
  static const coralSoft = Color(0xFFFFB59F);

  static const bg = Color(0xFFFFF7F4);
  static const card = Color(0xFFF7F1EF);
  static const cardText = Colors.black87;

  static const navGradStart = Color(0xFFFFB49E);
  static const navGradEnd = Color(0xFFFFB49E);
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
                  const SizedBox(height: 12),

                  // ⬇️ کارتە گەورەتر + وێنە/تایتڵ گەورەتر
                  _HomeTile(
                    title: 'Creating Doors&Windows',
                    imagePath: 'assets/img/create.png',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CreateDoorDetailScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  _HomeTile(
                    title: 'Selling Aluminum',
                    imagePath: 'assets/img/alm.png',
                    onPressed: () {
                         Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SellAlmnium()),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  _HomeTile(
                    title: 'Selling Glass',
                    imagePath: 'assets/img/glass.png',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const saleglassscreen()),
                      );
                    },
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

/// —— کاستیەم کارت بۆ ماڵپەڕ ——
/// گەورەترکراوە: وێنە=90px، تایتڵ=18px، گۆشە=16، شادۆ نەرموو
class _HomeTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onPressed;

  const _HomeTile({
    required this.title,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(164, 0, 0, 0),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          foregroundColor: AppColors.cardText,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 90, // ⬅️ وێنە گەورەتر
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset(imagePath),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18, // ⬅️ ناو گەورەتر
                fontWeight: FontWeight.w700,
                color: AppColors.cardText,
                height: 1.15,
              ),
            ),
          ],
        ),
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
    const notchRadius = 32.0;
    const notchdynamic = notchRadius * 0.60;
    const hPad = 20.0;
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
                    left: cx - bubbleSize / 0.20,
                    top: -bubbleSize * 5.3,
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
      width: 60,
      height: 60,
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
