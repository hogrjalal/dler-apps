import 'package:flutter/material.dart';
import 'dart:math' as math;

/// هەمان ڕەنگەکان لە پڕۆژەی پێشوو
class AppColors {
  static const coralDark = Color(0xFFFF5A36);
  static const coralSoft = Color(0xFFFFB59F);
  static const card = Color(0xFFF7F1EF);
  static const text = Colors.black87;
}

class Createdoorscreen extends StatefulWidget {
  const Createdoorscreen({super.key});

  @override
  State<Createdoorscreen> createState() => _BrandsPageState();
}

class _BrandsPageState extends State<Createdoorscreen> {
  final _pageCtrl = PageController();
  int _index = 0;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _HeaderWave(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back + Logo
                  Row(
                    children: [
                      _BackBtn(onTap: () => Navigator.pop(context)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            "assets/img/logo.png",
                            height: 36,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 44), // balance
                    ],
                  ),
                  const SizedBox(height: 10),

                  // ===== Carousel =====
                  AspectRatio(
                    aspectRatio: 16 / 7.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: PageView(
                        controller: _pageCtrl,
                        onPageChanged: (i) => setState(() => _index = i),
                        children: const [
                          _HeroSlide(),
                          _SolidSlide(color: Color(0xFFFF9F8A), title: "Alu Profiles", subtitle: "300+ SKUs"),
                          _SolidSlide(color: Color(0xFF333A), title: "Custom Orders", subtitle: "Fast Delivery"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  // Dots indicator (٣ خاڵ)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(3, (i) {
                      final active = i == _index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: EdgeInsets.only(right: i == 2 ? 0 : 6),
                        width: active ? 14 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: active ? AppColors.coralDark : Colors.black12,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 18),

                  // ===== Cards =====
                  _ImageCard(
                    imagePath: "assets/img/tubes.jpg",
                    label: "Tube&Corner",
                    onTap: () {},
                  ),
                  const SizedBox(height: 14),
                  _ImageCard(
                    imagePath: "assets/img/accessories.jpg",
                    label: "accessories aluminium",
                    onTap: () {},
                  ),
                  const SizedBox(height: 14),
                  _BrandCard(
                    imagePath: "assets/img/brands_card.png", // panel with brand logos
                    label: "Brands",
                    onTap: () {},
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

/// موجەی سەرەوە + گرادیەنت
class _HeaderWave extends StatelessWidget {
  const _HeaderWave();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: double.infinity,
      child: ClipPath(
        clipper: _WaveClipper(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.coralSoft, AppColors.coralDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path()..lineTo(0, size.height * 0.55);
    p.quadraticBezierTo(size.width * 0.18, size.height * 0.40,
        size.width * 0.35, size.height * 0.48);
    p.quadraticBezierTo(size.width * 0.65, size.height * 0.62,
        size.width, size.height * 0.42);
    p.lineTo(size.width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _BackBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _BackBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Ink(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: AppColors.coralDark,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(Icons.arrow_back_ios_new_rounded,
            color: Colors.white, size: 18),
      ),
    );
  }
}

/// Slide with green gradient + window photo (like screenshot)
class _HeroSlide extends StatelessWidget {
  const _HeroSlide();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // green gradient bg
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0DA56A), Color(0xFF157B53)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        // title text left
        const Positioned(
          left: 18,
          top: 20,
          child: SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Premium",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800)),
                Text("Solutions",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800)),
                SizedBox(height: 8),
                Text("Strong & Durable",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        // product image right
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Image.asset(
            "assets/img/window_promo.png",
            width: 160,
            fit: BoxFit.cover,
          ),
        ),
        // rounded corners on whole slide
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _SolidSlide extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  const _SolidSlide(
      {required this.color, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          "$title\n$subtitle",
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

/// Generic image card with pill label overlay (Tube & Accessories)
class _ImageCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;
  const _ImageCard(
      {required this.imagePath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          width: double.infinity,
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              )
            ],
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.35),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// White card with logos + center pill that says "Brands"
class _BrandCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;
  const _BrandCard(
      {required this.imagePath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              )
            ],
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFE9E9E9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
