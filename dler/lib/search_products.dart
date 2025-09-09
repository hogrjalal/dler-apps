import 'package:flutter/material.dart';

void main() => runApp(const BrandProducts());

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BrandProductsScreen(),
    );
  }
}

class BrandProductsScreen extends StatefulWidget {
  const BrandProductsScreen({super.key});

  @override
  State<BrandProductsScreen> createState() => _BrandProductsScreenState();
}

class _BrandProductsScreenState extends State<BrandProductsScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String query = "";

  final List<Map<String, String>> _products = const [
    {"name": "ALD45", "image": "assets/products/image1.png"},
    {"name": "SL32",  "image": "assets/products/image1.png"},
    {"name": "SL28",  "image": "assets/products/image2.png"},
    {"name": "AS42",  "image": "assets/products/image1.png"},
    {"name": "C60",   "image": "assets/products/image1.png"},
    {"name": "C55",   "image": "assets/products/image2.png"},
    {"name": "LS60",  "image": "assets/products/image1.png"},
    {"name": "SL38",  "image": "assets/products/image1.png"},
    {"name": "TE62",  "image": "assets/products/image2.png"},
  ];

  // ڕاووتکردن بە پێی ناو: هەر ناوێک پەیجی تایبەتی هەیە
  final Map<String, Widget Function()> _routesByName = {
    "ALD45": () => const Ald45Screen(),
    "SL32":  () => const Sl32Screen(),
    "SL28":  () => const Sl28Screen(),
    "AS42":  () => const As42Screen(),
    "C60":   () => const C60Screen(),
    "C55":   () => const C55Screen(),
    "LS60":  () => const Ls60Screen(),
    "SL38":  () => const Sl38Screen(),
    "TE62":  () => const Te62Screen(),
  };

  @override
  Widget build(BuildContext context) {
    final filtered = _products
        .where((p) => p["name"]!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      body: Stack(
        children: [
          // Gradient header
          Image.asset(
            'assets/img/gradient_banner.png',
            width: double.infinity,
            height: 140,
            fit: BoxFit.cover,
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 30),

                // Back + Logo
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 50),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5A36),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 20),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                    ),
                    const SizedBox(width: 30),

                    // لۆگۆی ئەسیستال خوارەوەتر بەرزکراوە
                    Padding(
                      padding: const EdgeInsets.only(top: 90),
                      child: Image.asset(
                        "assets/brands/Asistal.png",
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),

                const SizedBox(height: 50),

                // Search box (327 × 49)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  child: GradientOutline(
                    radius: 30,
                    stroke: 1.6,
                    child: SizedBox(
                      width: 327,
                      height: 49,
                      child: TextField(
                        controller: _searchCtrl,
                        onChanged: (val) => setState(() => query = val),
                        decoration: const InputDecoration(
                          prefixIcon:
                              Icon(Icons.search, color: Colors.grey),
                          hintText: "Search",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Results
                Expanded(
                  child: filtered.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 60),
                            Image.asset(
                              "assets/img/search.png",
                              height: 147,
                              width: 147,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "No results found",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 20,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: filtered.length,
                          itemBuilder: (context, i) {
                            final product = filtered[i];
                            final name = product["name"]!;
                            final image = product["image"]!;
                            final heroTag = "hero_$name";

                            return InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                final builder = _routesByName[name];
                                if (builder != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => builder(),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetailsScreen(
                                        name: name,
                                        imagePath: image,
                                        heroTag: heroTag,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 112,
                                    height: 91,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1, // بۆردەری رەشی باریک
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              97, 0, 0, 0),
                                          blurRadius: 10,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                      child: Hero(
                                        tag: heroTag,
                                        child: Image.asset(
                                          image,
                                          height: 90,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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

/// ویجێتی گرادیەنت بۆ بۆردەر
class GradientOutline extends StatelessWidget {
  final Widget child;
  final double radius;
  final double stroke;

  const GradientOutline({
    super.key,
    required this.child,
    this.radius = 30,
    this.stroke = 1.6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(stroke),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: const LinearGradient(
          colors: [Color(0xFFEA4828), Color.fromARGB(255, 111, 135, 255)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius - 0.5),
        ),
        child: child,
      ),
    );
  }
}

/// پەیجی گشتیی وردەکاری ـ fallback
class ProductDetailsScreen extends StatelessWidget {
  final String name;
  final String imagePath;
  final String heroTag;
  const ProductDetailsScreen({
    super.key,
    required this.name,
    required this.imagePath,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: const Color(0xFFFF5A36),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: heroTag,
              child: Image.asset(
                imagePath,
                width: 240,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Details coming soon...",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ===================== پەیجە تایبەتەکان ===================== */

class Ald45Screen extends StatelessWidget {
  const Ald45Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const name = "ALD45";
    const image = "assets/products/image1.png";
    const heroTag = "hero_$name";

    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
        backgroundColor: const Color(0xFFFF5A36),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _DetailHeroImage(image: image, heroTag: heroTag),
            _DetailTitle(name: name),
            _DetailSubtitle(text: "ALD45 specs / images / docs here"),
          ],
        ),
      ),
    );
  }
}

class Sl32Screen extends StatelessWidget {
  const Sl32Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const name = "SL32";
    const image = "assets/products/image1.png";
    const heroTag = "hero_$name";
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
        backgroundColor: const Color(0xFFFF5A36),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _DetailHeroImage(image: image, heroTag: heroTag),
            _DetailTitle(name: name),
            _DetailSubtitle(text: "SL32 details page"),
          ],
        ),
      ),
    );
  }
}

class Sl28Screen extends StatelessWidget {
  const Sl28Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const name = "SL28";
    const image = "assets/products/image2.png";
    const heroTag = "hero_$name";
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
        backgroundColor: const Color(0xFFFF5A36),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _DetailHeroImage(image: image, heroTag: heroTag),
            _DetailTitle(name: name),
            _DetailSubtitle(text: "SL28 details page"),
          ],
        ),
      ),
    );
  }
}

class As42Screen extends StatelessWidget {
  const As42Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const name = "AS42";
    const image = "assets/products/image1.png";
    const heroTag = "hero_$name";
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
        backgroundColor: const Color(0xFFFF5A36),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _DetailHeroImage(image: image, heroTag: heroTag),
            _DetailTitle(name: name),
            _DetailSubtitle(text: "AS42 details page"),
          ],
        ),
      ),
    );
  }
}

class C60Screen extends StatelessWidget {
  const C60Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const name = "C60";
    const image = "assets/products/image1.png";
    const heroTag = "hero_$name";
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
        backgroundColor: const Color(0xFFFF5A36),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _DetailHeroImage(image: image, heroTag: heroTag),
            _DetailTitle(name: name),
            _DetailSubtitle(text: "C60 details page"),
          ],
        ),
      ),
    );
  }
}

class C55Screen extends StatelessWidget {
  const C55Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const name = "C55";
    const image = "assets/products/image2.png";
    const heroTag = "hero_$name";
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
        backgroundColor: const Color(0xFFFF5A36),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _DetailHeroImage(image: image, heroTag: heroTag),
            _DetailTitle(name: name),
            _DetailSubtitle(text: "C55 details page"),
          ],
        ),
      ),
    );
  }
}

class Ls60Screen extends StatelessWidget {
  const Ls60Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const name = "LS60";
    const image = "assets/products/image1.png";
    const heroTag = "hero_$name";
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
        backgroundColor: const Color(0xFFFF5A36),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _DetailHeroImage(image: image, heroTag: heroTag),
            _DetailTitle(name: name),
            _DetailSubtitle(text: "LS60 details page"),
          ],
        ),
      ),
    );
  }
}

class Sl38Screen extends StatelessWidget {
  const Sl38Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const name = "SL38";
    const image = "assets/products/image1.png";
    const heroTag = "hero_$name";
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
        backgroundColor: const Color(0xFFFF5A36),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _DetailHeroImage(image: image, heroTag: heroTag),
            _DetailTitle(name: name),
            _DetailSubtitle(text: "SL38 details page"),
          ],
        ),
      ),
    );
  }
}

class Te62Screen extends StatelessWidget {
  const Te62Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const name = "TE62";
    const image = "assets/products/image2.png";
    const heroTag = "hero_$name";
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
        backgroundColor: const Color(0xFFFF5A36),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _DetailHeroImage(image: image, heroTag: heroTag),
            _DetailTitle(name: name),
            _DetailSubtitle(text: "TE62 details page"),
          ],
        ),
      ),
    );
  }
}

/* ======== ویدجێتە تەکرارکراوەکانی پەیجە وردەکاری ======== */

class _DetailHeroImage extends StatelessWidget {
  final String image;
  final String heroTag;
  const _DetailHeroImage({required this.image, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Image.asset(
        image,
        width: 240,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _DetailTitle extends StatelessWidget {
  final String name;
  const _DetailTitle({required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Text(
        name,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _DetailSubtitle extends StatelessWidget {
  final String text;
  const _DetailSubtitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 14, color: Colors.black54),
    );
  }
}
