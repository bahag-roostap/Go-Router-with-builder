import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchSuggestionsList extends StatelessWidget {
  const SearchSuggestionsList({super.key});

  static const autocompletion = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: autocompletion.length,
          itemBuilder: (context, index) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              context.push("/productList/${autocompletion[index]}");
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
                            autocompletion[index],
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
    );
  }
}
