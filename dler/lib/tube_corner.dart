import 'package:flutter/material.dart';

void main() => runApp(const TubeApp());

class TubeApp extends StatelessWidget {
  const TubeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TubeCornerPage(),
    );
  }
}

class TubeCornerPage extends StatefulWidget {
  const TubeCornerPage({super.key});
  @override
  State<TubeCornerPage> createState() => _TubeCornerPageState();
}

class _TubeCornerPageState extends State<TubeCornerPage> {
  // brand
  final _brands = const ["Asistal", "Schüco", "Aluk", "Other"];
  String _brand = "Asistal";

  // shapes
  final _shapes = const [
    "assets/item/shape1.png",
    "assets/item/shape 2.png",
    "assets/item/shape1.png",
    "assets/item/shape 2.png",
    "assets/item/shape1.png",
  ];
  int _shapeIndex = 0;

  // color
  final _colors = const ["Brown", "Black", "Silver", "White"];
  String _color = "Brown";

  // qty & desc
  int _qty = 1;
  final _desc = TextEditingController();

  @override
  void dispose() {
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFFFF5A36);

    return Scaffold(
      body: Stack(
        children: [
          // header wave (asset gradient)
          Image.asset(
            "assets/img/gradient_banner.png",
            width: double.infinity,
            height: 170,
            fit: BoxFit.cover,
          ),
           

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 55),
                  
                  // back + logo
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      Container(
                        width: 40,
                        height: 60,
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
                       const SizedBox(width: 40),
                      Image.asset(
                        "assets/img/logo.png",
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      const Spacer(),
                    ],
                  ),

                  const SizedBox(height: 50),

                  // Aluminum Brand label + dropdown (gradient border like shot)
                 Column(
  crossAxisAlignment: CrossAxisAlignment.start, // لە چەپ دەست پێبکات
  children: [
    const _FieldLabel("Aluminum Brand"),
    const SizedBox(height: 6),
    Center( // ⬅️ ناوەراست کردنی DropDown بە تەنها
      child: SizedBox(
        width: 267,
        height: 40,
        child: _GradientOutline(
          radius: 12,
          stroke: 1.2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonHideUnderline(
             
              child: DropdownButton<String>(
                
                value: _brand,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                items: _brands
                    .map((b) => DropdownMenuItem(
                          value: b,
                          child: Text(b),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _brand = v!),
              ),
            ),
          ),
        ),
      ),
    ),
  ],
),


                  const SizedBox(height: 16),

                 // Select Shape
const _FieldLabel("Select Shape :"),
const SizedBox(height: 8),
GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: _shapes.length,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    mainAxisExtent: 90, // بەرزی کارت
  ),
  itemBuilder: (context, i) {
    final selected = _shapeIndex == i;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => setState(() => _shapeIndex = i),
      child: SizedBox(
        width: 100,  // ⬅️ پانی کارت
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(112, 0, 0, 0),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
            border: Border.all(
              color: selected ? primary : const Color(0x11000000),
              width: selected ? 2 : 1,
            ),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              _shapes[i],
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_outlined, size: 34),
            ),
          ),
        ),
      ),
    );
  },
),



                  const SizedBox(height: 16),

                  // color + quantity row
                  Row(
  children: [
    // color
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel("Aluminum color"),
        const SizedBox(height: 6),
        SizedBox(
          width: 166,
          height: 40,
          child: _GradientOutline(
            radius: 12,
            stroke: 1.2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _color,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: _colors
                      .map((c) => DropdownMenuItem(
                            value: c,
                            child: Row(
                              children: [
                                _ColorDot(name: c),
                                const SizedBox(width: 8),
                                Text(c),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _color = v!),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    const SizedBox(width: 12),

    // quantity
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel("Quantity"),
        const SizedBox(height: 6),
        SizedBox(
          width: 166,
          height: 40,
          child: _QtyStepper(
            value: _qty,
            onChanged: (v) => setState(() => _qty = v.clamp(1, 999)),
          ),
        ),
      ],
    ),
  ],
),


                  const SizedBox(height: 16),

                 // descriptions
const _FieldLabel("Descriptions"),
const SizedBox(height: 6),
SizedBox(
  width: 352,
  height: 98.42,
  child: _GradientOutline(
    radius: 12,
    stroke: 1.2,
    child: Stack(
      children: [
        TextField(
          controller: _desc,
          maxLines: 6,
          maxLength: 500,
          decoration: const InputDecoration(
            hintText: "Write here...",
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 28),
            counterText: "",
          ),
        ),
        // counter (bottom-right)
        Positioned(
          right: 10,
          bottom: 8,
          child: Text(
            "${_desc.text.length}/500",
            style: const TextStyle(color: Colors.black45, fontSize: 12),
          ),
        ),
      ],
    ),
  ),
),


                  const SizedBox(height: 16),

                  // add to cart
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text(
                        "Add to cart",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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

/* ---------- helpers ---------- */

class _FieldLabel extends StatelessWidget { final String text; const _FieldLabel(this.text); @override Widget build(BuildContext context) { return Text( text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w500), ); } }

class _GradientOutline extends StatelessWidget {
  final Widget child;
  final double radius;
  final double stroke;
  const _GradientOutline({required this.child, this.radius = 12, this.stroke = 1.2});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(stroke),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: const LinearGradient(
          colors: [Color(0xFFEA4828), Color(0xFF6F87FF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius - .5),
        ),
        child: child,
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final String name;
  const _ColorDot({required this.name});

  Color _map() {
    switch (name.toLowerCase()) {
      case "brown":
        return const Color(0xFF6A3E12);
      case "black":
        return Colors.black87;
      case "silver":
        return const Color(0xFFBDBDBD);
      case "white":
        return Colors.white;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _map();
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: c,
        border: Border.all(color: const Color.fromARGB(36, 0, 0, 0)),
      ),
    );
  }
}

class _QtyStepper extends StatefulWidget {
  final int value;
  final ValueChanged<int> onChanged;
  const _QtyStepper({required this.value, required this.onChanged});

  @override
  State<_QtyStepper> createState() => _QtyStepperState();
}

class _QtyStepperState extends State<_QtyStepper> {
  static const primary = Color(0xFFFF5A36);
  bool _plusPressed = false;

  @override
  Widget build(BuildContext context) {
    return _GradientOutline(
      radius: 12,
      stroke: 1.2,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            // minus
            _RoundIcon(
              icon: Icons.remove,
              bgColor: Colors.white,
              iconColor: const Color.fromARGB(221, 255, 72, 0),
              onTap: () => widget.onChanged(widget.value > 1 ? widget.value - 1 : 1),
            ),

            // value
            Expanded(
              child: Center(
                child: Text(
                  "${widget.value}",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            // plus (changes bg to primary while pressed)
            _RoundIcon(
              icon: Icons.add,
              bgColor: _plusPressed ? primary : Colors.white,
              iconColor: _plusPressed ? const Color.fromARGB(255, 240, 4, 4) : primary,
              onTap: () => widget.onChanged(widget.value + 1),
              onTapDown: (_) => setState(() => _plusPressed = true),
              onTapCancel: () => setState(() => _plusPressed = false),
              onTapUp: (_) => setState(() => _plusPressed = false),
            ),
          ],
        ),
      ),
    );
  }
}

/// Round icon button with optional press callbacks
class _RoundIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color bgColor;
  final Color iconColor;
  final void Function(TapDownDetails)? onTapDown;
  final void Function()? onTapCancel;
  final void Function(TapUpDetails)? onTapUp;

  const _RoundIcon({
    required this.icon,
    required this.onTap,
    this.bgColor = const Color.fromARGB(255, 255, 0, 0),
    this.iconColor = Colors.black87,
    this.onTapDown,
    this.onTapCancel,
    this.onTapUp,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onTapDown: onTapDown,
      onTapCancel: onTapCancel,
      onTapUp: onTapUp,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0x22000000)),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}
