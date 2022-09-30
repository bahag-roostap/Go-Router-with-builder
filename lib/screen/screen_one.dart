import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_test/services/navigation/route_constants.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({
    required this.screenId,
    super.key,
  });

  final double screenId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('screen id is: $screenId')),
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
