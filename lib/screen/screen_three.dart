import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_test/services/navigation/route_constants.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({
    required this.screenStr,
    super.key,
  });

  final String screenStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('screen message is: $screenStr')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go(RouteConstants.homeRoute);
              },
              child: const Text('go to home'),
            ),
          ],
        ),
      ),
    );
  }
}
