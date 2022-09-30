import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_test/screen/home.dart';
import 'package:go_router_test/screen/screen_one.dart';
import 'package:go_router_test/screen/screen_three.dart';
import 'package:go_router_test/screen/screen_two.dart';
import 'package:go_router_test/services/navigation/route_constants.dart';

part 'navigator.g.dart';

final goRouter = GoRouter(
  routes: $appRoutes,
);

@TypedGoRoute<HomeRoute>(path: RouteConstants.homeRoute)
class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context) => const Home();
}

@TypedGoRoute<ScreenOneRoute>(
    path: '${RouteConstants.screenOneRoute}/:screenId')
class ScreenOneRoute extends GoRouteData {
  ScreenOneRoute({required this.screenId});

  final double screenId;

  @override
  Widget build(BuildContext context) => ScreenOne(screenId: screenId);
}

@TypedGoRoute<ScreenTwoRoute>(
    path: '${RouteConstants.screenTwoRoute}/:screenId')
class ScreenTwoRoute extends GoRouteData {
  ScreenTwoRoute({required this.screenId});

  final double screenId;
  @override
  Widget build(BuildContext context) => ScreenTwo(screenId: screenId);
}

@TypedGoRoute<ScreenThreeRoute>(
    path: '${RouteConstants.screenThreeRoute}/:string')
class ScreenThreeRoute extends GoRouteData {
  ScreenThreeRoute({required this.string});

  final String string;
  @override
  Widget build(BuildContext context) => ScreenThree(screenStr: string);
}
