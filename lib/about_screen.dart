import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.close),
        ),
        title: const Text("about"),
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text("about"),
        ),
      ),
    );
  }
}
