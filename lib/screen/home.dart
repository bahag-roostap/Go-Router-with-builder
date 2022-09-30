import 'package:flutter/material.dart';
import 'package:go_router_test/services/navigation/navigator.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                //context.go(RouteConstants.screenOneRoute);
                ScreenOneRoute(screenId: 4).go(context);
              },
              child: const Text('go to screen 1'),
            ),
            ElevatedButton(
              onPressed: () {
                //context.go(RouteConstants.screenTwoRoute);
                ScreenTwoRoute(screenId: 15).go(context);
              },
              child: const Text('go to screen 2'),
            ),
            ElevatedButton(
              onPressed: () {
                // context.go(RouteConstants.screenThreeRoute);
                ScreenThreeRoute(string: 'this is the third screen')
                    .go(context);
              },
              child: const Text('go to screen 3'),
            )
          ],
        ),
      ),
    );
  }
}
