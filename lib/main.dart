import 'package:flutter/material.dart';
import 'package:go_router_test/services/navigation/navigator.dart';

void main() {
  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    ),
  );
}
