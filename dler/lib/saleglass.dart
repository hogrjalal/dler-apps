import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';
import 'package:dler/singleglass.dart';

import 'package:flutter/material.dart';



class GradientBanner extends StatelessWidget {
  const GradientBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/img/gradient_banner.png",
      width: double.infinity, // پر دەکات بە پەنی شاشە
      height: 132,
      fit: BoxFit.cover,
    );
  }
}
class saleglassscreen extends StatelessWidget {
  const saleglassscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientBanner(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button + Logo
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 18),
                        onPressed: () => Navigator.pop(context),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            const Color(0xFFFF5A36),
                          ),
                          shape: WidgetStateProperty.all(
                            const CircleBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 0),
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            "assets/img/logo.png",
                            height: 46,
                          ),
                        ),
                      ),
                      const SizedBox(width: 78), // بۆ بالانس
                    ],
                  ),

                  const SizedBox(height: 70),

                  // Cards
                  CategoryCard(
                    imagePath: "assets/img/single.png",
                    label: "Single Pane",
                    onTap: () {
                      Navigator.push( context, MaterialPageRoute(builder: (_) => const Singleglassscreen()), );
                    },
                  ),
                  const SizedBox(height: 38),
                  CategoryCard(
                    imagePath: "assets/img/double.png",
                    label: "Double Pane",
                    onTap: () {
                      
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

/// موجەکەی سەرەوە
class _HeaderWave extends StatelessWidget {
  const _HeaderWave();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: double.infinity,
      child: ClipPath(
        clipper: _WaveClipper(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFB59F), Color(0xFFFF5A36)],
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
    final Path path = Path()..lineTo(0, size.height * 0.55);
    path.quadraticBezierTo(
      size.width * 0.18,
      size.height * 0.40,
      size.width * 0.35,
      size.height * 0.48,
    );
    path.quadraticBezierTo(
      size.width * 0.65,
      size.height * 0.62,
      size.width,
      size.height * 0.42,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// کارتەکان
class CategoryCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 236, 235, 235),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(169, 0, 0, 0),
                blurRadius: 10,
                
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
  height: 100,
  child: FittedBox(
    fit: BoxFit.contain,
    child: Transform.scale(
      scale: 1.2, // ⬅️ 20% گەورەتر
      child: Image.asset(imagePath),
    ),
  ),
),

              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
