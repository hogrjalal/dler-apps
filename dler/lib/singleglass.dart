import 'package:flutter/material.dart';

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

class Singleglassscreen extends StatefulWidget {
  const Singleglassscreen({super.key});

  @override
  State<Singleglassscreen> createState() => _GlassOrderPageState();
}

class _GlassOrderPageState extends State<Singleglassscreen> {
  final TextEditingController widthCtrl = TextEditingController(text: "235");
  final TextEditingController heightCtrl = TextEditingController(text: "235");
  final TextEditingController descCtrl = TextEditingController();

  String glassBrand = "Turkish";
  String glassColor = "Gray";
  String glassThickness = "6 mm";
  String glassType = "Clear";

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
                  const SizedBox(height: 35),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        onPressed: () => Navigator.pop(context),
                        style: ButtonStyle(
                          
                          backgroundColor: WidgetStateProperty.all(
                              const Color(0xFFFF5A36)),
                          shape: WidgetStateProperty.all(const CircleBorder()),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            "assets/img/logo.png",
                            height: 40,
                          ),
                        ),
                      ),
                      const SizedBox(width: 88),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),

                          /// Width & Height
                          Row(
                            children: [
                              Expanded(
                                child: _InputBox(
                                  label: "Width",
                                  prefix: "W",
                                  controller: widthCtrl,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _InputBox(
                                  label: "Height",
                                  prefix: "H",
                                  controller: heightCtrl,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          /// Brand & Color
                          Row(
                            children: [
                              
                              Expanded(
                                child: _DropdownBox(
                                  height: 36,
                                  label: "Glass Brand",
                                  value: glassBrand,
                                  items: const ["Turkish", "German", "Italian"],
                                  onChanged: (v) =>
                                      setState(() => glassBrand = v!),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
  child: _DropdownBox(
    height: 36,
    label: "Glass Color",
    value: glassColor,
    showColorSwatch: true,
    items: const ["Gray", "Blue", "Green", "Brown"],
    onChanged: (v) => setState(() => glassColor = v!),
  ),
),

                            ],
                          ),
                          const SizedBox(height: 8),

                          /// Thickness & Type
                          Row(
                            children: [
                              Expanded(
                                child: _DropdownBox(
                                  height: 36,
                                  label: "Glass Thickness",
                                  value: glassThickness,
                                  items: const ["4 mm", "6 mm", "8 mm", "10 mm"],
                                  onChanged: (v) =>
                                      setState(() => glassThickness = v!),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _DropdownBox(
                                  height: 36,
                                  label: "Glass Type",
                                  value: glassType,
                                  items: const ["Clear", "Frosted", "Tinted"],
                                  onChanged: (v) =>
                                      setState(() => glassType = v!),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),

                          /// Quantity
                          Align(
                            
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Quantity",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 12.5),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const SizedBox(width: 40),
                          Row(
  children: [
    Container(
      height: 43,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        gradient: const LinearGradient(
          colors: [Color(0xFFEA4828), Color.fromARGB(255, 61, 77, 248)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.all(1.6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (quantity > 1) {
                  setState(() => quantity--);
                }
              },
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
    const Spacer(), // ⬅️ ئەمە شتەکانی تر ببە لای راست
  ],
),

                          
                        
                          
                          const SizedBox(height: 4),

                          /// Descriptions
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Descriptions",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 12.5),
                            ),
                          ),
                          const SizedBox(height: 1),
                          _gradientBorder(
                            radius: 12,
                            innerPadding: const EdgeInsets.fromLTRB(
                                10, 6, 10, 6),
                            child: TextField(
                              controller: descCtrl,
                              maxLines: 4,
                              maxLength: 500,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                hintText: "Write here...",
                                counterText: "",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Add to cart
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 12),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5A36),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text(
                        "Add to cart",
                        style: TextStyle(fontSize: 16,height: 1,),
                      ),
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

/// Gradient border wrapper
Widget _gradientBorder({
  required Widget child,
  double radius = 12,
  EdgeInsetsGeometry innerPadding =
      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
}) {
  return Container(
    padding: const EdgeInsets.all(1.6),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius - 0.5),
      ),
      child: child,
    ),
  );
}

/// Input box (Width/Height)
class _InputBox extends StatelessWidget {
  final String label;
  final String prefix;
  final TextEditingController controller;

  const _InputBox({
    required this.label,
    required this.prefix,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 12.5)),
        const SizedBox(height: 6),
        _gradientBorder(
          radius: 12,
          innerPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(31, 243, 243, 243),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  prefix,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 12),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 8),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 1),
              const Text(
                'cm',
                style: TextStyle(fontSize: 12, color: Color.fromARGB(136, 0, 0, 0)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Dropdown box
class _DropdownBox extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final double height;
  final bool showColorSwatch; // ⬅️ نوێ: تەنها بۆ Glass Color true بکە

  const _DropdownBox({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.height = 40,
    this.showColorSwatch = false, // ⬅️ بە بنەڕەت ناچالاکە
  });

  Color _mapColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case "gray":
        return Colors.grey;
      case "blue":
        return Colors.blue;
      case "green":
        return Colors.green;
      case "brown":
        return Colors.brown;
      case "red":
        return Colors.red;
      case "black":
        return Colors.black;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    // بنەمای item ـی هاوبەش (بە swatch یان بێ swatch)
    Widget _buildItem(String e) {
      if (!showColorSwatch) {
        return Text(e, style: const TextStyle(fontSize: 13));
      }
      return Row(
        children: [
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: _mapColor(e),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black26),
            ),
          ),
          Text(e, style: const TextStyle(fontSize: 13)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: 12.5),
        ),
        const SizedBox(height: 6),
        _gradientBorder(
          radius: 12,
          innerPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: SizedBox(
            height: height,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down_rounded, size: 20),
                style: const TextStyle(fontSize: 14, color: Colors.black87),

                // ⬇️ بۆ ئەوەی کاتێک دابخراوە (selected state)ش swatch ببینرێت
                selectedItemBuilder: showColorSwatch
                    ? (context) => items
                        .map((e) => Align(
                              alignment: Alignment.centerLeft,
                              child: _buildItem(e),
                            ))
                        .toList()
                    : null,

                items: items
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: _buildItem(e),
                        ))
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
