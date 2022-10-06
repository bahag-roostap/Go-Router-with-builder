// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigator.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<GoRoute> get $appRoutes => [
      $homeRoute,
      $categoriesRoute,
      $diyRoute,
      $cartRoute,
    ];

GoRoute get $homeRoute => GoRouteData.$route(
      path: '/home',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: ':cmsId',
          factory: $SubHomeRouteExtension._fromState,
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $SubHomeRouteExtension on SubHomeRoute {
  static SubHomeRoute _fromState(GoRouterState state) => SubHomeRoute(
        cmsId: state.params['cmsId']!,
      );

  String get location => GoRouteData.$location(
        '/home/${Uri.encodeComponent(cmsId)}',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

GoRoute get $categoriesRoute => GoRouteData.$route(
      path: '/categories',
      factory: $CategoriesRouteExtension._fromState,
    );

extension $CategoriesRouteExtension on CategoriesRoute {
  static CategoriesRoute _fromState(GoRouterState state) => CategoriesRoute();

  String get location => GoRouteData.$location(
        '/categories',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

GoRoute get $diyRoute => GoRouteData.$route(
      path: '/diy',
      factory: $DiyRouteExtension._fromState,
    );

extension $DiyRouteExtension on DiyRoute {
  static DiyRoute _fromState(GoRouterState state) => DiyRoute();

  String get location => GoRouteData.$location(
        '/diy',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

GoRoute get $cartRoute => GoRouteData.$route(
      path: '/cart',
      factory: $CartRouteExtension._fromState,
    );

extension $CartRouteExtension on CartRoute {
  static CartRoute _fromState(GoRouterState state) => CartRoute();

  String get location => GoRouteData.$location(
        '/cart',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}
