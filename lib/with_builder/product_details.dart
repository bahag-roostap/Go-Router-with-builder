import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
            onPressed: context.pop, color: Colors.black87),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: const Center(
                child: Text(
                  'Product Details',
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Related products',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
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
          const SizedBox(height: 48),
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
