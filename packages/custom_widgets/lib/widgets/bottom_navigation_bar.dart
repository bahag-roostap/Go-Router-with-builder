import 'package:flutter/material.dart';

import '../corporate_design/color.dart';

class BottomNavBar extends StatefulWidget {
  final List<IconData> icons;
  final Function(int) onPressed;
  final int activeIndex;

  const BottomNavBar({
    super.key,
    required this.icons,
    required this.onPressed,
    required this.activeIndex,
  });

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);
    return Container(
      color: colors.background,
      child: Row(
        children: [
          for (var i = 0; i < widget.icons.length; i++)
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => widget.onPressed(i),
              child: Container(
                width: mediaQuery.size.width / widget.icons.length,
                height: mediaQuery.viewPadding.bottom + 50,
                padding: const EdgeInsets.only(bottom: 20),
                child: Icon(
                  widget.icons[i],
                  color: i == widget.activeIndex
                      ? colors.bottomTabBarIconActive
                      : colors.bottomTabBarIcon,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
