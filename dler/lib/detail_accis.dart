import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final String selectedImage;
  final String title;
  const ProductDetailPage({
    super.key,
    required this.selectedImage,
    this.title = "Lever Door Handle",
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
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

class _ProductDetailPageState extends State<ProductDetailPage> {
  // -------- State --------
  int quantity = 1;
  String selectedColor = "Brown";
  final TextEditingController _descCtrl = TextEditingController();
  final FocusNode _descFocus = FocusNode();
  final FocusNode _ddFocus = FocusNode();

  final List<String> colors = const ["Brown", "Black", "Silver", "White"];

  // رەنگەکان
  static const Color kPrimary = Color(0xFFFF5A36);
  static const Color kBlue    = Color(0xFF2E7DD7);
  


  Color _colorFromName(String name) {
    switch (name) {
      case "Brown":  return const Color(0xFF6B3A14);
      case "Black":  return const Color(0xFF1F1F1F);
      case "Silver": return const Color(0xFFB0B8C2);
      case "White":  return const Color(0xFFF5F5F5);
      default:       return Colors.grey;
    }
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    _descFocus.dispose();
    _ddFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF8),
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
                      onPressed: () => Navigator.maybePop(context),
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

            // ---------------- Content ----------------
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                children: [
                  const SizedBox(height: 77),
                 SizedBox(
  width: 183,
  height: 140,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(
      color: Colors.white,
      child: Image.asset(
        widget.selectedImage,
        fit: BoxFit.contain, // ژێر قەبارەی 183×140 دەجۆڵێت
      ),
    ),
  ),
),

                  const SizedBox(height: 20),
                
                  const SizedBox(height: 20),
                  const Text("Lever Door Handle",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black87)),
                  const SizedBox(height: 118),

                  // --------- Row: Color (Dropdown) + Quantity ----------
                  Row(
                    children: [
                      // Dropdown (Gradient border)
                      SizedBox(
  width: 166, // ✅ فیکس
  child: GradientOutline(
    label: "Aluminum color",
    isFocused: _ddFocus.hasFocus,
    stroke: 1.0, // نزمتر بۆ گونجاندنی 40px
    child: SizedBox(
      height: 38, // ✅ هاوچێوەی 40 بە حسابی stroke
      child: DropdownButtonFormField<String>(
        focusNode: _ddFocus,
        value: selectedColor,
        decoration: const InputDecoration(
          isDense: true, // نزمکردنی بەرزی داخڵ
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        ),
        iconSize: 18,
        style: const TextStyle(fontSize: 14),
        items: colors.map((c) => DropdownMenuItem(
          value: c,
          child: Row(
            children: [
              Container(
                width: 18, height: 18,
                margin: EdgeInsetsDirectional.only(end: 8),
                decoration: BoxDecoration(
                  color: _colorFromName(c),
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0x22000000)),
                ),
              ),
              Text(c),
            ],
          ),
        )).toList(),
        onChanged: (v) => setState(() => selectedColor = v ?? selectedColor),
      ),
    ),
  ),
),


                      const SizedBox(width: 12),

                      // Quantity (Gradient border)
                      Expanded(
                        child: GradientOutline(
                          label: "Quantity",
                          isFocused: false,
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              children: [
                                const SizedBox(width: 6),
                                _QtyBtn(icon: Icons.remove, onTap: (){
                                  if (quantity > 1) setState(()=>quantity--);
                                }),
                                const Spacer(),
                                Text("$quantity", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                const Spacer(),
                                _QtyBtn(icon: Icons.add, onTap: ()=> setState(()=>quantity++)),
                                const SizedBox(width: 6),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Descriptions (Gradient border)
                 // قەبارە و ستروک


SizedBox(
  width: 352, 
  // ✅ 352px
  child: GradientOutline(
    label: "Descriptions",
    isFocused: _descFocus.hasFocus,
    stroke: 1.6, // هەمانەی کۆمپۆنەنتەکەت
    child: SizedBox(
      // ✅ 98.42 - (stroke * 2) بۆ ئەوەی بۆردەرە گرادیەنتی بە هەمان قەبارەدا بێت
      height: 98.42 - (1.6 * 2),
      child: TextField(
        focusNode: _descFocus,
        controller: _descCtrl,
        // بۆ فیکسکردنی قەبارە: expands=true و max/minLines=null
        expands: true,
        minLines: null,
        maxLines: null,
        maxLength: 500,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: "",
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        onChanged: (_) => setState(() {}),
      ),
    ),
  ),
),


                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("${_descCtrl.text.length}/500",
                        style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),

            // -------- Add to cart --------
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
              child: SizedBox(
                width: double.infinity, height: 52,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text("Add to cart", style: TextStyle(fontSize: 18, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text("Added • ${widget.title}\nColor: $selectedColor | Qty: $quantity"),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Widgets ----------------

/// Gradient border container (دوورەنگی تێکەل شین+پرایمەری)
class GradientOutline extends StatelessWidget {
  final Widget child;
  final String? label;
  final bool isFocused;
  final double radius;
  final double stroke;   // دۆوری بۆردەر

  const GradientOutline({
    super.key,
    required this.child,
    this.label,
    required this.isFocused,
    this.radius = 10,
    this.stroke = 1.6,
  });

  static const Color _primary = _ProductDetailPageState.kPrimary;
  static const Color _blue    = _ProductDetailPageState.kBlue;

  @override
  Widget build(BuildContext context) {
    // لە focus ـدا بڕی بۆردەر زۆرتر بکە و گرادیەنت بەرزتر بێت
    final double borderWidth = isFocused ? (stroke + 0.6) : stroke;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6, left: 4),
            child: Text(label!, style: const TextStyle(fontSize: 12, color: Colors.black87)),
          ),
        // قەبارەی دەرەوە: گرادیەنت
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius + 2),
            gradient: const LinearGradient(
              colors: [Color.fromARGB(255, 255, 98, 1), Color.fromARGB(255, 26, 125, 255)], // شین تا پرایمەری
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          padding: EdgeInsets.all(borderWidth), // قەبارەی بۆردەر
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFFE3DB),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 28, height: 28,
          child: Icon(Icons.add, size: 18, color: _ProductDetailPageState.kPrimary), // will be overridden
        ),
      ),
    );
  }
}
