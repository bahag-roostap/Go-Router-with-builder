// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigator.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<GoRoute> get $appRoutes => [
      $homeRoute,
      $screenOneRoute,
      $screenTwoRoute,
      $screenThreeRoute,
    ];

GoRoute get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

GoRoute get $screenOneRoute => GoRouteData.$route(
      path: '/screenone/:screenId',
      factory: $ScreenOneRouteExtension._fromState,
    );

extension $ScreenOneRouteExtension on ScreenOneRoute {
  static ScreenOneRoute _fromState(GoRouterState state) => ScreenOneRoute(
        screenId: double.parse(state.params['screenId']!),
      );

  String get location => GoRouteData.$location(
        '/screenone/${Uri.encodeComponent(screenId.toString())}',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

GoRoute get $screenTwoRoute => GoRouteData.$route(
      path: '/screentwo/:screenId',
      factory: $ScreenTwoRouteExtension._fromState,
    );

extension $ScreenTwoRouteExtension on ScreenTwoRoute {
  static ScreenTwoRoute _fromState(GoRouterState state) => ScreenTwoRoute(
        screenId: double.parse(state.params['screenId']!),
      );

  String get location => GoRouteData.$location(
        '/screentwo/${Uri.encodeComponent(screenId.toString())}',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

GoRoute get $screenThreeRoute => GoRouteData.$route(
      path: '/screenthree/:string',
      factory: $ScreenThreeRouteExtension._fromState,
    );

extension $ScreenThreeRouteExtension on ScreenThreeRoute {
  static ScreenThreeRoute _fromState(GoRouterState state) => ScreenThreeRoute(
        string: state.params['string']!,
      );

  String get location => GoRouteData.$location(
        '/screenthree/${Uri.encodeComponent(string)}',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}
