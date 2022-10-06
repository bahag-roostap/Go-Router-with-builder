import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        title: const Text("profile"),
      ),
      body: ListView(
        controller: PrimaryScrollController.of(context),
        children: [
          Container(
            color: Colors.blueGrey,
            child: const Center(
              child: Text("about"),
            ),
          ),
          Container(
            color: Colors.greenAccent,
            child: const Center(
              child: Text("what"),
            ),
          ),
          Container(
            color: Colors.deepOrange,
            child: const Center(
              child: Text("adasd asda sd a"),
            ),
          ),
          Container(
            color: Colors.blueGrey,
            child: const Center(
              child: Text("sadasd asd asd asds"),
            ),
          ),
          Container(
            color: Colors.amber,
            child: const Center(
              child: Text("abasd asd asd out"),
            ),
          ),
          const Text("an image"),
          Image.network("https://media.bahag.cloud/m/331936/12.webp"),
          const Text("an image"),
          Image.network("https://media.bahag.cloud/m/438662/12.webp"),
          const Text("an image"),
          Image.network("https://media.bahag.cloud/m/667058/12.webp"),
          Container(
            color: Colors.blueGrey,
            child: const Center(
              child: Text("about"),
            ),
          ),
        ],
      ),
    );
  }
}
