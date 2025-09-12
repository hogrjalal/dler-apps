import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // دەتوانیت ئەم ناوە بگۆڕیت یان بە .image(...) بانگ بکەیت
      home: BrandProductsScreen.name(brandName: 'Asistal'),
    );
  }
}

/* ===================== Brand Products Screen ===================== */

class BrandProductsScreen extends StatefulWidget {
  final String? brandImagePath; // پاثی وێنەی براند (ئارەزوومەندانە)
  final String? brandName;      // ناوی براند (ئارەزوومەندانە)

  const BrandProductsScreen.image({
    super.key,
    required String this.brandImagePath,
  }) : brandName = null;

  const BrandProductsScreen.name({
    super.key,
    required String this.brandName,
  }) : brandImagePath = null;

  @override
  State<BrandProductsScreen> createState() => _BrandProductsScreenState();
}

class _BrandProductsScreenState extends State<BrandProductsScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String query = "";

  // ناو → پاثی لۆگۆ (ئەمە خۆت گەورە بکە)
  String? _logoFromName(String name) {
    const logos = <String, String>{
      'Asistal': 'assets/brands/2.png',
      'Schüco':  'assets/brands/1.png',
    };
    return logos[name];
  }

  String? get _resolvedLogoPath {
    if (widget.brandImagePath != null) return widget.brandImagePath!;
    if (widget.brandName != null) return _logoFromName(widget.brandName!);
    return null;
  }

  String get _fallbackTitle {
    if (widget.brandName != null) return widget.brandName!;
    final path = widget.brandImagePath ?? '';
    final file = path.split('/').last;
    final dot = file.lastIndexOf('.');
    final base = dot == -1 ? file : file.substring(0, dot);
    return base.isEmpty ? 'Brand' : base;
  }

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

  @override
  Widget build(BuildContext context) {
    final logoPath = _resolvedLogoPath;
    final filtered = _products
        .where((p) => p["name"]!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      body: Stack(
        children: [
          // Gradient header (asset)
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

                // Back + Brand logo (لە ناوەراست، سایز نەدەن)
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
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.only(top: 90),
                      child: logoPath != null
                          ? Center(
                              child: Image.asset(
                                logoPath,
                                fit: BoxFit.contain, // وێنە بە شێوەی خۆی
                              ),
                            )
                          : Text(
                              _fallbackTitle,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // Search box (327×49)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
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
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          hintText: "Search",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                            Image.asset("assets/img/search.png", height: 147, width: 147),
                            const SizedBox(height: 12),
                            const Text("No results found",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          ],
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(20),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                             
                              child: Column(
                                children: [
                                  Container(
                                    width: 112,
                                    height: 91,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black, width: 1),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(97, 0, 0, 0),
                                          blurRadius: 10,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Hero(
                                        tag: heroTag,
                                        child: Image.asset(image, height: 90, fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
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





class GradientOutline extends StatelessWidget {
  final Widget child;
  final double radius;
  final double stroke;

  const GradientOutline({super.key, required this.child, this.radius = 30, this.stroke = 1.6});

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
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(radius - 0.5)),
        child: child,
      ),
    );
  }
}

