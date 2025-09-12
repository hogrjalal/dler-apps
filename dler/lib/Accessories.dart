import 'package:flutter/material.dart';
import 'itemacc.dart';
import 'sell_almnium.dart';

void main() => runApp(const AccessoriesApp());

class AccessoriesApp extends StatelessWidget {
  const AccessoriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AccessoriesPage(),
    );
  }
}

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

class AccessoriesPage extends StatefulWidget {
  const AccessoriesPage({super.key});

  @override
  State<AccessoriesPage> createState() => _AccessoriesPageState();
}

class _AccessoriesPageState extends State<AccessoriesPage> {
  // هەموو وێنەکان
  final List<String> _images = const [
    "assets/item/image 29.png",
    "assets/item/image 30.png",
    "assets/item/image 31.png",
    "assets/item/image 32.png",
    "assets/item/image 33.png",
    "assets/item/image 34.png",
    "assets/item/image 35.png",
    "assets/item/image 36.png",
    "assets/item/image 31.png",
    "assets/item/image 34.png",
    "assets/item/image 36.png",
    "assets/item/image 33.png",
  ];

  // ئەندێکسی هەڵبژاردن: null واتا هیچ‌هەڵبژاردن نیە
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Gradient Banner + Logo + Back button
            Stack(
              children: [
                const GradientBanner(),
                Positioned(
                  top: 93,
                  left: 50,
                  child: Container(
                    width: 35,
                    height: 34,
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
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SellAlmnium(
                      
                        ),
                      ),
                    ),
                    ),
                  ),
                ),
                Positioned(
                  top: 85,
                  right: 135,
                  child: Image.asset(
                    "assets/img/logo.png",
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 36),

            const Text(
              "Select the accessory you need",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 35),

            // Scrollable grid (Selectable Cards)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedIndex == index;
                  return _SelectableCard(
                    imagePath: _images[index],
                    selected: isSelected,
                    onTap: () {
                      setState(() => _selectedIndex = index);
                    },
                  );
                },
              ),
            ),

            // Next button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 98, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_selectedIndex == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("تکایە یەک کارد هەڵبژێرە."),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return;
                    }

                    // ⬇️ ئەگەر دەتەوێت وێنەی هەڵبژاردوو ببات بۆ پەڕەی داهاتوو:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Itemaccscreen(
                      
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// وێجێتی کاردی هەڵبژێردراو
class _SelectableCard extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final VoidCallback onTap;

  const _SelectableCard({
    required this.imagePath,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: selected ? 5 : 3,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Stack(
          children: [
            // Content
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: selected ? 2.0 : 1.0,
                  color: selected ? const Color(0xFFFF5A36) : const Color(0x11000000),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Checkmark Badge when selected
            if (selected)
              const Positioned(
                top: 6,
                left: 6,
                child: _CheckBadge(),
              ),
          ],
        ),
      ),
    );
  }
}

class _CheckBadge extends StatelessWidget {
  const _CheckBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(
        color: Color(0xFFFF5A36),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(Icons.check, size: 16, color: Colors.white),
    );
  }
}
