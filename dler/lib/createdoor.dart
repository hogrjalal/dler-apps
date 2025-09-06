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

class CreateDoorDetailScreen extends StatefulWidget {
  const CreateDoorDetailScreen({super.key});

  @override
  State<CreateDoorDetailScreen> createState() => _CreateDoorDetailScreenState();
}

class _CreateDoorDetailScreenState extends State<CreateDoorDetailScreen> {
  final TextEditingController widthCtrl  = TextEditingController(text: "235");
  final TextEditingController heightCtrl = TextEditingController(text: "235");
  final TextEditingController descCtrl   = TextEditingController();

  String aluminumColor = "Brown";
  String glassType     = "Clear";
  String aluminumType  = "Sliding";

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
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 26),
                        onPressed: () => Navigator.pop(context),
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(const Color(0xFFFF5A36)),
                          shape: WidgetStateProperty.all(const CircleBorder()),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            "assets/img/logo.png",
                            height: 50,
                          ),
                        ),
                      ),
                      const SizedBox(width: 88),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          /// Width & Height
                          Row(
                            children: [
                              SizedBox(
                                width: 166,
                                child: _InputBox(
                                  label: "Width",
                                  prefix: "W",
                                  controller: widthCtrl,
                                ),
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                width: 166,
                                child: _InputBox(
                                  label: "Height",
                                  prefix: "H",
                                  controller: heightCtrl,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),

                          /// Aluminum Color + Quantity
                          Row(
                            children: [
                              SizedBox(
                                width: 166,
                                child: _DropdownBox(
                                  label: "Aluminum color",
                                  value: aluminumColor,
                                  showColorSwatch: true,
                                  items: const ["Brown", "Black", "Gray", "White"],
                                  onChanged: (v) =>
                                      setState(() => aluminumColor = v!),
                                ),
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                width: 166,
                                child: _QuantityBox(
                                  value: quantity,
                                  onChanged: (v) =>
                                      setState(() => quantity = v),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),

                          /// Glass Type + Upload Image
                          Row(
                            children: [
                              SizedBox(
                                width: 166,
                                child: _DropdownBox(
                                  label: "Glass type",
                                  value: glassType,
                                  items: const ["Clear", "Frosted", "Tinted"],
                                  onChanged: (v) =>
                                      setState(() => glassType = v!),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    // TODO: handle file picker
                                  },
                                  child: DottedBorderBox(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.upload, color: Colors.red),
                                        Text("Upload image",
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),

                          /// Aluminum Type
                          Row(
                            children: [
                              SizedBox(
                                width: 166,
                                child: _DropdownBox(
                                  label: "Aluminum type",
                                  value: aluminumType,
                                  items: const ["Sliding", "Fixed", "Openable"],
                                  onChanged: (v) =>
                                      setState(() => aluminumType = v!),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),

                          /// Descriptions
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Descriptions",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: 14)),
                          ),
                          const SizedBox(height: 6),
                          _gradientBorder(
                            radius: 12,
                            stroke: 1.0,
                            innerPadding:
                                const EdgeInsets.fromLTRB(10, 6, 10, 6),
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Add to Cart Button
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 12, bottom: 12),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5A36),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text("Add to cart",
                          style: TextStyle(fontSize: 16, height: 1)),
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

/// Gradient border (reusable)
Widget _gradientBorder({
  required Widget child,
  double radius = 12,
  double stroke = 1.0,
  EdgeInsetsGeometry innerPadding =
      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius - 0.5),
      ),
      child: child,
    ),
  );
}

/// InputBox
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
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        const SizedBox(height: 6),
        SizedBox(
          height: 40,
          child: _gradientBorder(
            radius: 12,
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(31, 243, 243, 243),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(prefix,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 12)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('cm',
                    style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// DropdownBox
class _DropdownBox extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool showColorSwatch;

  const _DropdownBox({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.showColorSwatch = false,
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
      case "black":
        return Colors.black;
      case "white":
        return Colors.white;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildItem(String e) {
      if (!showColorSwatch) {
        return Text(e, style: const TextStyle(fontSize: 14));
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
          Text(e, style: const TextStyle(fontSize: 14)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        const SizedBox(height: 6),
        SizedBox(
          height: 40,
          child: _gradientBorder(
            radius: 12,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down_rounded, size: 20),
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                selectedItemBuilder: showColorSwatch
                    ? (context) => items
                        .map((e) => Align(
                              alignment: Alignment.centerLeft,
                              child: _buildItem(e),
                            ))
                        .toList()
                    : null,
                items: items
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: _buildItem(e)))
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

/// Quantity Box
class _QuantityBox extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const _QuantityBox({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _gradientBorder(
      radius: 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              if (value > 1) onChanged(value - 1);
            },
          ),
          Text("$value", style: const TextStyle(fontSize: 14)),
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFFFF5A36)),
            onPressed: () => onChanged(value + 1),
          ),
        ],
      ),
    );
  }
}

/// Upload Image Box (Dotted)
class DottedBorderBox extends StatelessWidget {
  final Widget child;
  const DottedBorderBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.red.shade200,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: Center(child: child),
    );
  }
}
