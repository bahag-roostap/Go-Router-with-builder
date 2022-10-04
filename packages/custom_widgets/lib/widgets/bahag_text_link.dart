import 'package:custom_widgets/corporate_design/color.dart';
import 'package:flutter/material.dart';

class BahagTextLink extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const BahagTextLink({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline5?.copyWith(
              decoration: TextDecoration.underline,
              color:
                  onPressed != null ? null : BahagColor.darkGrey.withAlpha(77),
            ),
      ),
    );
  }
}
