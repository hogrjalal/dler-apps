import 'package:flutter/material.dart';

void main() => runApp(const brands());

class brands extends StatelessWidget {
  const brands({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F6F5),
        fontFamily: 'Roboto',
      ),
      home: const BrandssScreen(),
    );
  }
}

class BrandssScreen extends StatefulWidget {
  const BrandssScreen({super.key});

  @override
  State<BrandssScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandssScreen> {
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
          // سەرەوە Gradient
          Image.asset(
            'assets/img/gradient_banner.png',
            width: double.infinity,
            height: 170,
            fit: BoxFit.cover,
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // back + logo
                Row(
                  children: [
                    const SizedBox(width: 20),
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
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 20),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/img/logo.png',
                      height: 48,
                      fit: BoxFit.contain,
                    ),
                    const Spacer(),
                    const SizedBox(width: 40),
                  ],
                ),

                const SizedBox(height: 20),

                // Carousel بانەرەکان
                SizedBox(
                  height: 144,
                  child: PageView(
                    controller: _pageCtl,
                    onPageChanged: (i) => setState(() => _page = i),
                    children: const [
                      _PromoImageSlide(image: 'assets/reklam/banner.png'),
                      _PromoImageSlide(image: 'assets/reklam/banner2.jpg'),
                      _PromoImageSlide(image: 'assets/reklam/banner3.jpg'),
                    ],
                  ),
                ),

                // دۆتەکان
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 8),
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

                const SizedBox(height: 30),

                // Grid بۆ برندەکان
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.9,
                      children: const [
                        _BrandButton(image: 'assets/brands/1.png'),
                        _BrandButton(image: 'assets/brands/2.png'),
                        _BrandButton(image: 'assets/brands/3.png'),
                        _BrandButton(image: 'assets/brands/4.png'),
                        _BrandButton(image: 'assets/brands/6.png'),
                       
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =================== Slide Card ===================
class _PromoImageSlide extends StatelessWidget {
  final String image;
  final double radius;
  final EdgeInsets margin;

  const _PromoImageSlide({
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
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}


 // =================== Brand Card (fills card with image) ===================
 class _BrandButton extends StatelessWidget {
  final String image;
  final VoidCallback? onTap;

  const _BrandButton({required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    const radius = 16.0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(17, 0, 0, 0),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap ?? () {},
            child: Ink.image(
              image: AssetImage(image),
              fit: BoxFit.cover,              // ⬅️ وێنەکە تەواو کارت دەگرێت
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
    }
}
