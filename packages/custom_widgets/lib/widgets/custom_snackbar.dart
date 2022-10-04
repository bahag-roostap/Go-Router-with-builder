import 'package:flutter/material.dart';
import '../corporate_design/color.dart';

class BahaggErrorSnackbar extends StatelessWidget {
  final String title;
  final String message;

  const BahaggErrorSnackbar({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: BahagColor.nearlyWhite),
            ),
          ),
          Text(message),
        ],
      ),
    );
  }
}
