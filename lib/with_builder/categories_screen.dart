import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({this.category, super.key});
  final String? category;

  @override
  Widget build(BuildContext context) {
    final categories = List.generate(
      15,
      (index) => Category(
        title: 'Category $index',
        subCategories: names.map((e) => Category(title: e)).toList(),
      ),
    );

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              (GoRouter.of(context).canPop())
                  ? IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    )
                  : const SizedBox(width: 20),
              Text(
                category ?? 'All Categories',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  context.push("/products/${categories[index].title}");
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 3),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                categories[index].title,
                                style: Theme.of(context).textTheme.copyTextH4,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  final String title;
  final List<Category> subCategories;

  const Category({required this.title, this.subCategories = const []});
}

const names = [
  'Pruning shears',
  'Rake',
  'Wheelbarrow',
  'Garden hose',
  'Loppers',
  'Spading fork',
  'Watering can',
  'Pruning Saw',
  'The U-Shaped Kitchen',
  'The Island Kitchen',
  'The Peninsula Kitchen',
  'The L-Shaped Kitchen',
  'The Galley Kitchen',
  'The One Wall Kitchen',
  'Pruning shears',
  'Rake',
  'Wheelbarrow',
  'Garden hose',
  'Loppers',
  'Spading fork',
  'Watering can',
  'Pruning Saw',
  'The U-Shaped Kitchen',
  'The Island Kitchen',
  'The Peninsula Kitchen',
  'The L-Shaped Kitchen',
  'The Galley Kitchen',
  'The One Wall Kitchen',
];
