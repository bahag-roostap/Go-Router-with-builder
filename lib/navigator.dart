import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'categories_screen.dart';
import 'common/custom_transitions.dart';
import 'common/widgets/base_screen.dart';
import 'common/widgets/content_screen.dart';
import 'constants.dart';
import 'home_screen.dart';

part 'navigator.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

const PageStorageKey mykey1 = PageStorageKey("testkey1");
const PageStorageKey mykey2 = PageStorageKey("testkey2");
final PageStorageBucket bucket1 = PageStorageBucket();
final PageStorageBucket bucket2 = PageStorageBucket();

final goRouter = GoRouter(
  initialLocation: RouteConstants.homeRoute,
  navigatorKey: _rootNavigatorKey,
  routes: $appRoutes,
  // observers: ,
);

@TypedGoRoute<HomeRoute>(
  path: RouteConstants.homeRoute,
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<SubHomeRoute>(
      path: ':cmsId',
    )
  ],
)
class HomeRoute extends GoRouteData {
  @override
  Page<Function> buildPageWithState(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      key: state.pageKey,
      child: const BaseScreen(
        child: HomeScreenContent(),
      ),
    );
  }
}

class SubHomeRoute extends GoRouteData {
  SubHomeRoute({required this.cmsId});

  final String cmsId;

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.greenAccent,
        child: Center(
          child: Text("home $cmsId"),
        ),
      );
}

@TypedGoRoute<CategoriesRoute>(
  path: RouteConstants.categoriesRoute,
  routes: <TypedGoRoute<GoRouteData>>[],
)
class CategoriesRoute extends GoRouteData {
  @override
  Page<Function> buildPageWithState(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      key: state.pageKey,
      child: const BaseScreen(
        child: CategoriesScreen(),
      ),
    );
  }
}

@TypedGoRoute<DiyRoute>(
  path: RouteConstants.diyRoute,
  routes: <TypedGoRoute<GoRouteData>>[],
)
class DiyRoute extends GoRouteData {
  @override
  Page<Function> buildPageWithState(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      key: state.pageKey,
      child: BaseScreen(
        child: ContentScreen(
          storageKey: mykey1,
          storageBucket: bucket1,
        ),
      ),
    );
  }
}

@TypedGoRoute<CartRoute>(
  path: RouteConstants.cartRoute,
  routes: <TypedGoRoute<GoRouteData>>[],
)
class CartRoute extends GoRouteData {
  @override
  Page<Function> buildPageWithState(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      key: state.pageKey,
      child: BaseScreen(
        child: ContentScreen(
          storageKey: mykey2,
          storageBucket: bucket2,
        ),
      ),
    );
  }
}
