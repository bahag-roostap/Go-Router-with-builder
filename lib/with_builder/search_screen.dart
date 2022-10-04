import 'package:custom_widgets/corporate_design/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BahagColor.nearlyWhite,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () => context.push('/product/$index'),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Fake product title',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final images = [
  'https://media.bahag.cloud/m/331936/12.webp',
  'https://media.bahag.cloud/m/438662/12.webp',
  'https://media.bahag.cloud/m/667058/12.webp',
  'https://media.bahag.cloud/m/331936/12.webp',
  'https://media.bahag.cloud/m/438662/12.webp',
  'https://media.bahag.cloud/m/667058/12.webp',
];
