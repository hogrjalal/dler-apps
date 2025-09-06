import 'package:flutter/material.dart';

/// همان هێدەرە هەڵکەوتووە لە Single Glass
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

class DoubleGlassScreen extends StatefulWidget {
  const DoubleGlassScreen({super.key});
  @override
  State<DoubleGlassScreen> createState() => _DoubleGlassScreenState();
}

class _DoubleGlassScreenState extends State<DoubleGlassScreen> {
  // top inputs (same as single glass)
  final TextEditingController widthCtrl  = TextEditingController(text: "235");
  final TextEditingController heightCtrl = TextEditingController(text: "235");
  final TextEditingController descCtrl   = TextEditingController();

  // outer pane
  String outerThickness = "8 mm";
  String outerBrand     = "Turkish";
  String outerColor     = "Gray";
  String outerType      = "Clear";

  // inner pane
  String innerThickness = "6 mm";
  String innerBrand     = "Turkish";
  String innerColor     = "Gray";
  String innerType      = "Clear";

  // others
  String spaceBetween   = "8 mm";
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientBanner(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // header (same spacing as single)
                  const SizedBox(height: 58),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
                        onPressed: () => Navigator.pop(context),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(const Color(0xFFFF5A36)),
                          shape: WidgetStateProperty.all(const CircleBorder()),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Image.asset("assets/img/logo.png", height: 60),
                        ),
                      ),
                      const SizedBox(width: 98),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Width & Height (166×40 exactly)
                          Row(
                            children: [
                              SizedBox(
                                width: 166,
                                child: _InputBox(label: "Width",  prefix: "W", controller: widthCtrl),
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                width: 166,
                                child: _InputBox(label: "Height", prefix: "H", controller: heightCtrl),
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          // Outer & Inner Pane side-by-side (each full width in column)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _PaneCard(
                                  title: "Outer Pane",
                                  thickness: outerThickness,
                                  brand: outerBrand,
                                  color: outerColor,
                                  type: outerType,
                                  onChanged: (t, b, c, tp) {
                                    setState(() {
                                      outerThickness = t; outerBrand = b; outerColor = c; outerType = tp;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _PaneCard(
                                  title: "Inner Pane",
                                  thickness: innerThickness,
                                  brand: innerBrand,
                                  color: innerColor,
                                  type: innerType,
                                  onChanged: (t, b, c, tp) {
                                    setState(() {
                                      innerThickness = t; innerBrand = b; innerColor = c; innerType = tp;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          // Quantity & Space between
                          Row(
                            children: [
                              // Quantity (166×40 inside gradient)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Quantity", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                                  const SizedBox(height: 6),
                                  SizedBox(
                                    height: 40,
                                    width: 166,
                                    child: _gradientBorder(
                                      stroke: 1.0,
                                      radius: 12,
                                      innerPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
                                          ),
                                          Text("$quantity", style: const TextStyle(fontSize: 14)),
                                          IconButton(
                                            icon: const Icon(Icons.add, color: Color(0xFFFF5A36)),
                                            onPressed: () => setState(() => quantity++),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                width: 166,
                                child: _DropdownBox(
                                  height: 40,
                                  label: "Space between glasses",
                                  value: spaceBetween,
                                  items: const ["6 mm", "8 mm", "10 mm", "12 mm"],
                                  onChanged: (v) => setState(() => spaceBetween = v!),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          // Descriptions
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Descriptions",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                          ),
                          const SizedBox(height: 6),
                          _gradientBorder(
                            stroke: 1.0,
                            radius: 12,
                            innerPadding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                            child: TextField(
                              controller: descCtrl,
                              maxLines: 4,
                              maxLength: 500,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true, counterText: "", border: InputBorder.none, hintText: "Write here...",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Add to cart (slightly up, same style)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10, bottom: 12),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5A36),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text("Add to cart", style: TextStyle(fontSize: 16, height: 1)),
                    ),
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

/// ---------------- Pane Card (uses the same 166×40 fields) ----------------
class _PaneCard extends StatelessWidget {
  final String title;
  final String thickness, brand, color, type;
  final void Function(String t, String b, String c, String tp) onChanged;

  const _PaneCard({
    required this.title,
    required this.thickness,
    required this.brand,
    required this.color,
    required this.type,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),

          SizedBox(
            width: 166,
            child: _DropdownBox(
              height: 40,
              label: "Glass Thickness",
              value: thickness,
              items: const ["4 mm", "6 mm", "8 mm", "10 mm"],
              onChanged: (v) => onChanged(v!, brand, color, type),
            ),
          ),
          const SizedBox(height: 12),

          SizedBox(
            width: 166,
            child: _DropdownBox(
              height: 40,
              label: "Glass Brand",
              value: brand,
              items: const ["Turkish", "German", "Italian"],
              onChanged: (v) => onChanged(thickness, v!, color, type),
            ),
          ),
          const SizedBox(height: 12),

          SizedBox(
            width: 166,
            child: _DropdownBox(
              height: 40,
              label: "Glass Color",
              value: color,
              showColorSwatch: true, // only here shows color dot
              items: const ["Gray", "Blue", "Green", "Brown"],
              onChanged: (v) => onChanged(thickness, brand, v!, type),
            ),
          ),
          const SizedBox(height: 12),

          SizedBox(
            width: 166,
            child: _DropdownBox(
              height: 40,
              label: "Glass Type",
              value: type,
              items: const ["Clear", "Frosted", "Tinted"],
              onChanged: (v) => onChanged(thickness, brand, color, v!),
            ),
          ),
        ],
      ),
    );
  }
}

/// --------------- Shared helpers (exactly same style as Single Glass) ---------------
Widget _gradientBorder({
  required Widget child,
  double radius = 12,
  double stroke = 1.0,
  EdgeInsetsGeometry innerPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
}) {
  return Container(
    padding: EdgeInsets.all(stroke),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      gradient: const LinearGradient(
        colors: [Color(0xFFEA4828), Color.fromARGB(255, 70, 70, 246)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: Container(
      padding: innerPadding,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(radius - 0.5)),
      child: child,
    ),
  );
}

class _InputBox extends StatelessWidget {
  final String label;
  final String prefix;
  final TextEditingController controller;
  const _InputBox({required this.label, required this.prefix, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
        const SizedBox(height: 6),
        SizedBox(
          height: 40,
          child: _gradientBorder(
            radius: 12,
            stroke: 1.0,
            innerPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: const Color.fromARGB(31, 243, 243, 243), borderRadius: BorderRadius.circular(8)),
                  child: Text(prefix, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(isDense: true, border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 10)),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('cm', style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DropdownBox extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final double height;
  final bool showColorSwatch;

  const _DropdownBox({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.height = 40,
    this.showColorSwatch = false,
  });

  Color _mapColor(String c) {
    switch (c.toLowerCase()) {
      case "gray": return Colors.grey;
      case "blue": return Colors.blue;
      case "green": return Colors.green;
      case "brown": return Colors.brown;
      default: return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _item(String e) {
      if (!showColorSwatch) return Text(e, style: const TextStyle(fontSize: 14));
      return Row(
        children: [
          Container(width: 16, height: 16, margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: _mapColor(e), shape: BoxShape.circle, border: Border.all(color: Colors.black26))),
          Text(e, style: const TextStyle(fontSize: 14)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
        const SizedBox(height: 6),
        SizedBox(
          height: height,
          child: _gradientBorder(
            radius: 12,
            stroke: 1.0,
            innerPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down_rounded, size: 20),
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                selectedItemBuilder: showColorSwatch
                    ? (ctx) => items.map((e) => Align(alignment: Alignment.centerLeft, child: _item(e))).toList()
                    : null,
                items: items.map((e) => DropdownMenuItem<String>(value: e, child: _item(e))).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
