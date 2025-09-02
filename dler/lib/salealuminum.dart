import 'package:flutter/material.dart';

class Salealuminumscreen extends StatelessWidget {
  const Salealuminumscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Creating Doors & Windows")),
      body: const Center(
        child: Text(
          "This is the Create Door & Windows Page",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
