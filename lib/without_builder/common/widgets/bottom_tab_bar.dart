import 'dart:ui';

import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_test/without_builder/store/widgets/scrollable_sheet.dart';

class BottomTabBar extends StatelessWidget {
  BottomTabBar({super.key});

  final icons = List<IconData>.unmodifiable(const [
    BahagIcons.bottomNavbarHome,
    BahagIcons.bottomNavbarProducts,
    BahagIcons.bottomNavbarDiy,
    BahagIcons.bottomNavbarCart,
  ]);
  final routes = ['/home', '/products', '/diy', '/cart'];

  @override
  Widget build(BuildContext context) {
    String location = GoRouter.of(context).location;
    double givenWidth = MediaQuery.of(context).size.width / 5;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 85,
      child: ClipPath(
        clipper: SheetCircleLowerClipper(),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            color: const Color.fromARGB(200, 240, 240, 240),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => GoRouter.of(context).go("/home"),
                  child: SizedBox(
                    width: givenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[0],
                          color: location.contains("home")
                              ? Colors.redAccent
                              : Colors.blueGrey,
                        ),
                        const SizedBox(
                          height: 7.5,
                        ),
                        Text(
                          "Start",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: location == "/home"
                                        ? Colors.redAccent
                                        : Colors.blueGrey,
                                    fontSize: 13,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => GoRouter.of(context).go("/products"),
                  child: SizedBox(
                    width: givenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[1],
                          color: location == "/products"
                              ? Colors.redAccent
                              : Colors.blueGrey,
                        ),
                        const SizedBox(
                          height: 7.5,
                        ),
                        Text(
                          "Produkte",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: location == "/products"
                                        ? Colors.redAccent
                                        : Colors.blueGrey,
                                    fontSize: 13,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: givenWidth,
                  height: double.maxFinite,
                  child: const Center(child: Text("Vor Ort")),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => GoRouter.of(context).go("/diy"),
                  child: SizedBox(
                    width: givenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[2],
                          color: location == "/diy"
                              ? Colors.redAccent
                              : Colors.blueGrey,
                        ),
                        const SizedBox(
                          height: 7.5,
                        ),
                        Text(
                          "DIY",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: location == "/diy"
                                        ? Colors.redAccent
                                        : Colors.blueGrey,
                                    fontSize: 13,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => GoRouter.of(context).go("/cart"),
                  child: SizedBox(
                    width: givenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[3],
                          color: location == "/cart"
                              ? Colors.redAccent
                              : Colors.blueGrey,
                        ),
                        const SizedBox(
                          height: 7.5,
                        ),
                        Text(
                          "Warenkorb",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: location == "/cart"
                                        ? Colors.redAccent
                                        : Colors.blueGrey,
                                    fontSize: 13,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
