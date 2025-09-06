// app_bottom_nav.dart
import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const bubbleSize = 6.0;
    const notchRadius = 32.0;
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

              double centerX(int index) => hPad + slotWidth * index + slotWidth / 2;
              final cx = centerX(currentIndex);

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // پشتەی ناڤبار + نۆچ
                  Positioned.fill(
                    child: _AnimatedCustomPaint(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOutCubic,
                      painter: _BarPainter(
                        notchCenterX: cx,
                        notchRadius: notchRadius,
                      ),
                    ),
                  ),

                  // ئایکۆن و تایتڵەکان
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
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

                  // گۆڵەی لە سەر نۆچ
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutBack,
                    left: cx - bubbleSize / 0.20,
                    top: -bubbleSize * 5.3,
                    child: _FloatingBubble(
                      child: Icon(
                        icons[currentIndex],
                        color: const Color(0xFFFFFFFF),
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

// ====== ژمارەی پێینتی ناڤباڕ ======
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
    final notchPath = Path()..addOval(Rect.fromCircle(center: notchCenter, radius: notchRadius));

    final carved = Path.combine(PathOperation.difference, rectPath, notchPath);

    final paint = Paint()..shader = shader;
    canvas.drawPath(carved, paint);
    canvas.drawShadow(carved, const Color.fromARGB(0, 0, 0, 0), 12, false);
  }

  @override
  bool shouldRepaint(covariant _BarPainter oldDelegate) {
    return oldDelegate.notchCenterX != notchCenterX || oldDelegate.notchRadius != notchRadius;
  }
}

class _AnimatedCustomPaint extends ImplicitlyAnimatedWidget {
  final CustomPainter painter;

  const _AnimatedCustomPaint({
    super.key,
    required this.painter,
    required Duration duration,
    Curve curve = Curves.linear,
  }) : super(duration: duration, curve: curve);

  @override
  ImplicitlyAnimatedWidgetState<_AnimatedCustomPaint> createState() => _AnimatedCustomPaintState();
}

class _AnimatedCustomPaintState extends ImplicitlyAnimatedWidgetState<_AnimatedCustomPaint> {
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
