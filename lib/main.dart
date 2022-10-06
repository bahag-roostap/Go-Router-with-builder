import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_test/about_screen.dart';
import 'package:go_router_test/categories_screen.dart';
import 'package:go_router_test/common/service/firebase_analytics.dart';
import 'package:go_router_test/common/widgets/base_screen.dart';
import 'package:go_router_test/product_details.dart';
import 'package:go_router_test/profile_screen.dart';
import 'package:go_router_test/search_screen.dart';

import 'common/service/go_router_observer.dart';
import 'common/widgets/content_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

const PageStorageKey mykey1 = PageStorageKey("testkey1");
const PageStorageKey mykey2 = PageStorageKey("testkey2");
const PageStorageKey mykey3 = PageStorageKey("testkey3");
final PageStorageBucket bucket1 = PageStorageBucket();
final PageStorageBucket bucket2 = PageStorageBucket();
final PageStorageBucket bucket3 = PageStorageBucket();

void main() {
  runApp(
    ProviderScope(
      child: BAUHAUSApp(),
    ),
  );
}

class BAUHAUSApp extends StatelessWidget {
  BAUHAUSApp({super.key});

  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    observers: [
      GoRouterObserver(analytics: FirebaseAnalytics()),
    ],
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/about',
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/profile',
        pageBuilder: (_, state) => SlideRoute(
          key: state.pageKey,
          beginOffset: const Offset(0, 1),
          child: const ProfileScreen(),
        ),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => BaseScreen(
          child: child,
        ),
        // pageBuilder: (BuildContext context, GoRouterState state, child) =>
        //     FadeTransitionPage(
        //   key: UniqueKey(),
        //   child: BaseScreen(child: child),
        // ),
        routes: <RouteBase>[
          GoRoute(
            path: '/home',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return FadeTransitionPage(
                key: state.pageKey,
                child: const HomeScreenContent(),
              );
            },
            routes: <RouteBase>[
              GoRoute(
                path: ':cmsId',
                builder: (BuildContext context, GoRouterState state) {
                  return Container(
                    color: Colors.greenAccent,
                    child: Center(
                      child: Text("home ${state.params['cmsId']}"),
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/products',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return FadeTransitionPage(
                key: state.pageKey,
                child: const CategoriesScreen(),
              );
              // return ContentScreen(
              //   storageKey: mykey1,
              //   storageBucket: bucket1,
              // );
            },
            routes: <RouteBase>[
              GoRoute(
                path: ':cName',
                builder: (BuildContext context, GoRouterState state) {
                  return CategoriesScreen(category: '${state.params['cName']}');
                },
              ),
            ],
          ),
          GoRoute(
            path: '/diy',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return FadeTransitionPage(
                key: state.pageKey,
                child: ContentScreen(
                  storageKey: mykey2,
                  storageBucket: bucket2,
                ),
              );
            },
          ),
          GoRoute(
            path: '/cart',
            pageBuilder: (_, state) {
              return FadeTransitionPage(
                key: state.pageKey,
                child: ContentScreen(
                  storageKey: mykey3,
                  storageBucket: bucket3,
                ),
              );
            },
          ),
          GoRoute(
            path: '/productList/:text',
            builder: (BuildContext context, GoRouterState state) {
              return SearchScreen(
                text: state.params['text'].toString(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/product/:pId',
        builder: (BuildContext context, GoRouterState state) {
          return const ProductDetails();
        },
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BAUHAUS',
      theme: BahagTheme.light,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}

class ListScreen extends StatelessWidget {
  const ListScreen({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Expanded(
          child: ListView.builder(
            itemCount: 50,
            itemBuilder: (_, index) => ListTile(
              title: Text('$index'),
            ),
          ),
        ),
      ],
    );
  }
}

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
                onPressed: () => GoRouter.of(context).push('/home/213123'),
                child: const Text("push params"))
          ],
        ),
      ),
    );
  }
}

/// A page that fades in an out.
class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              opacity: animation.drive(_curveTween),
              child: child,
            );
          },
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeOutSine);
}

class SlideRoute extends CustomTransitionPage<void> {
  SlideRoute({
    required LocalKey key,
    required Widget child,
    Offset beginOffset = const Offset(1.0, 0.0),
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: beginOffset,
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
