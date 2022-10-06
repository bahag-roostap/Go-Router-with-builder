import 'package:flutter/material.dart';
import 'package:go_router_test/navigator.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("home"),
            TextButton(
                onPressed: () => SubHomeRoute(cmsId: '213123').go(context),
                // onPressed: () => GoRouter.of(context).push('/home/213123'),
                child: const Text("push params"))
          ],
        ),
      ),
    );
  }
}
