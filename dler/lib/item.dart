import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductTypesScreen(),
    );
  }
}

class ProductTypesScreen extends StatelessWidget {
  const ProductTypesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Header
          Container(
            height: 160,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF5A36), Color(0xFFFF8C6C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Back Button
                Row(
                  children: [
                    const SizedBox(width: 12),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.red),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Logo + Brand Name
                Center(
                  child: Column(
                    children: [
                      Image.asset("assets/brands/Asistal.png",
                          height: 40, fit: BoxFit.contain),
                      const SizedBox(height: 8),
                      const Text(
                        "ASISTAL",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Product Image + Title
                Column(
                  children: [
                    Image.asset("assets/products/sl28.png",
                        height: 120, fit: BoxFit.contain),
                    const SizedBox(height: 8),
                    const Text("SL 28",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),

                const SizedBox(height: 20),

                // Product Types List
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: const [
                      _TypeCard(
                        image: "assets/products/sl28.png",
                        title: "2-Track Sliding Frame  (4.5 cm)",
                      ),
                      _TypeCard(
                        image: "assets/products/sl28.png",
                        title: "3-Track Sliding Frame  (7.5 cm)",
                      ),
                      _TypeCard(
                        image: "assets/products/sl28.png",
                        title: "2-Track Sliding Frame  (4.5 cm)",
                      ),
                    ],
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

/// Custom Card Widget
class _TypeCard extends StatelessWidget {
  final String image;
  final String title;

  const _TypeCard({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(image, height: 48, fit: BoxFit.contain),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          const Icon(Icons.arrow_forward_ios,
              size: 18, color: Colors.black54),
        ],
      ),
    );
  }
}
