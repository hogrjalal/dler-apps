import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Salealmscreen extends StatelessWidget {
  const Salealmscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            /// Logo & Back
            Row(
              children: [
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xFFFF5A36)),
                    shape: WidgetStateProperty.all(const CircleBorder()),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      "assets/img/logo.png",
                      height: 48,
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),

            const SizedBox(height: 20),

            /// Carousel Banner
            CarouselSlider(
              options: CarouselOptions(
                height: 160,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.88,
              ),
              items: [
                _bannerCard("assets/img/doors.png", "Premium Solutions\nStrong & Durable"),
                _bannerCard("assets/img/aluminum.png", "Aluminum Profiles\n30+ Designs"),
              ],
            ),

            const SizedBox(height: 20),

            /// Categories
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _categoryCard("assets/img/tube.png", "Tube & Corner"),
                  const SizedBox(height: 16),
                  _categoryCard("assets/img/accessories.png", "Accessories Aluminium"),
                  const SizedBox(height: 16),
                  _categoryCard("assets/img/brands.png", "Brands"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Banner Widget
  static Widget _bannerCard(String imagePath, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.5), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.bottomLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// Category Widget
  static Widget _categoryCard(String imagePath, String title) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.55),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
