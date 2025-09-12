import 'package:dler/home.dart';
import 'package:flutter/material.dart';
import 'brands.dart';
import 'tube_corner.dart';
import 'Accessories.dart';

void main() => runApp(const SellAlmnium());

class SellAlmnium extends StatelessWidget {
  const SellAlmnium({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F6F5),
        fontFamily: 'Roboto',
      ),
      home: const BrandsScreen(),
    );
  }
}

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  final _pageCtl = PageController(viewportFraction: 0.88);
  int _page = 0;

  @override
  void dispose() {
    _pageCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/img/gradient_banner.png',
            width: double.infinity,
            height: 170,
            fit: BoxFit.cover,
          ),
          SafeArea(
            
            child: Padding(
              
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // ⬅️ ناوەراست
                children: [
                   const SizedBox(height: 55),
                  Row(
                    children: [
                      const SizedBox(width: 45),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF5A36),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x26000000),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
                          onPressed: () =>  Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          ),
                        ),
                      ),
                      const SizedBox(width: 29),
                      Image.asset('assets/img/logo.png', height: 48, fit: BoxFit.contain),
                    ],
                  ),
                  const SizedBox(height: 40),

                SizedBox(
  height: 144,
   // ⬅️ پانای زیادکرا
  child: PageView(
    controller: _pageCtl,
    onPageChanged: (i) => setState(() => _page = i),
    children: const [
      _PromoImageSlide(image: 'assets/reklam/b1.png'),
      _PromoImageSlide(image: 'assets/reklam/b.png'),
      _PromoImageSlide(image: 'assets/reklam/b1.png'),
    ],
  ),
),



                  const SizedBox(height: 10),

                 // دۆتەکان لای چەپ
// دۆتەکان لای چەپ و هاوتای کارتەکان
Padding(
  padding: const EdgeInsets.only(left: 20, top: 8), // ⬅️ فاصله لە لای چەپ و سەرەوە
  child: Align(
    alignment: Alignment.centerLeft,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        3,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: i == _page ? 14 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: i == _page
                ? const Color(0xFFFF5A36)
                : const Color(0x33000000),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    ),
  ),
),



                  const SizedBox(height: 60),

                  // ⬇️ کارتە ناوەراست + شادۆ + ڕەیوس
                  _HomeImageCard(
                    image: 'assets/img/tube.png',
                    label: 'Tube&Corner',
                    width: 200,
                    height: 100,
                    onTap: () {
                       Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TubeCornerPage()),
        );
                    },
                  ),
                  const SizedBox(height: 40),
                  _HomeImageCard(
                    image: 'assets/img/sellalm.png',
                    label: 'accessories\naluminium',
                    width: 200,
                    height: 100,
                    onTap: () {
                               Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AccessoriesApp()),
        );
                    },
                  ),
                  const SizedBox(height: 40),
                  _HomeImageCard(
                    image: 'assets/img/brand.png',
                    label: 'brands',
                    width: 200,
                    height: 100,
                    onTap: () {
                       Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BrandssScreen()),
        );
                    },
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



// =================== PROMO CARD with curved image + green arc line ===================
class PromoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String rightImage; // assets path
  final Color leftColor;
  final Color rightColor;

  const PromoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rightImage,
    required this.leftColor,
    required this.rightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [leftColor, rightColor],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            
            // قەوسی سەوز (خەتی هێرشەک)
            Positioned.fill(
              child: CustomPaint(
                painter: _CurveBorderPainter(), // ⬅️ هەرە لە خوارەوە ناسراوە
              ),
            ),

            // وێنەی ڕاست بە قەوس clip
            Align(
              alignment: Alignment.centerRight,
              child: ClipPath(
                clipper: _CurveClipper(),
                child: Image.asset(
                  rightImage,
                  width: 190,              // قەبارەی وێنە
                  height: double.infinity, // پر بوون بە بەرزایی
                  fit: BoxFit.cover,       // بێ zoom نایە؛ بە شێوەی cover
                ),
              ),
            ),

            // نووسەکانی لای چەپ
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        height: 1.15,
                        fontWeight: FontWeight.w800,
                      )),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
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

/// قەوسی clip بۆ وێنەی ڕاست
class _CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path();
    // لە لاوەکی چەپدا قەوس بڕین
    p.moveTo(size.width * 0.8, 0);
    p.quadraticBezierTo(
      size.width * 0.8, size.height / 2,
      size.width * 0.8, size.height,
    );
    p.lineTo(size.width, size.height);
    p.lineTo(size.width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// painter بۆ خەتی قەوسی سەوز
class _CurveBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * 0.70, 0) // ⬅️ بە نزیک سنورێک لە ڕاست
      ..quadraticBezierTo(
        size.width * 0.60, size.height / 2,
        size.width * 0.70, size.height,
      );

    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF2ECC71), Color(0xFF18A05E)], // سەوزی کال + تۆنەوە
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// clipper بۆ وێنەی ڕاست

class _ImageTile extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final VoidCallback onTap;

  const _ImageTile({
    required this.image,
    required this.onTap,
    this.width = 200,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Ink(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x23000000),
                  blurRadius: 16,
                  offset: Offset(0, 10),
                ),
              ],
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover, // پرکردنەوەی تەواو وێنە وەکو کارتەکە
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PromoImageSlide extends StatelessWidget {
  final String image;
  final double radius;
  final EdgeInsets margin;

  const _PromoImageSlide({
    super.key,
    required this.image,
    this.radius = 18,
    this.margin = const EdgeInsets.only(right: 12),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(0, 0, 0, 0),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(image),
          
          fit: BoxFit.cover,   // وێنەکان تەواو کارت دەپوشێنن، بێ زوومێکی ناخۆش
          alignment: Alignment.center,
        ),
      ),
      // ClipRRect بۆ ئەوەی رەدیوس لە ڕەسمیش ڕێسپێکت بکرێت لە تەنیشتی شادۆ
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: const SizedBox.expand(),
      ),
    );
  }
}



class _HomeImageCard extends StatelessWidget {
  final String image;
  final String label;
  final double width;
  final double height;
  final VoidCallback onTap;

  const _HomeImageCard({
    required this.image,
    required this.label,
    required this.onTap,
    this.width = 200,   // ⬅️ قەبارەی کارت
    this.height = 100,  // ⬅️ قەبارەی کارت
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Ink(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x23000000),
                  blurRadius: 16,
                  offset: Offset(0, 10),
                ),
              ],
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,   // ⬅️ وێنە هەموو کارت دەگرێت
              ),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.86),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                    height: 1.1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
