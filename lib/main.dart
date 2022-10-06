import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router_test/navigator.dart';

void main() {
  runApp(
    const ProviderScope(
      child: BAUHAUSApp(),
    ),
  );
}

class BAUHAUSApp extends StatelessWidget {
  const BAUHAUSApp({super.key});

  // final GoRouter _router = GoRouter(
  //   navigatorKey: _rootNavigatorKey,
  //   initialLocation: '/home',
  //   routes: <RouteBase>[
  //     GoRoute(
  //       parentNavigatorKey: _rootNavigatorKey,
  //       path: '/about',
  //       builder: (context, state) => const AboutScreen(),
  //     ),
  //     GoRoute(
  //       parentNavigatorKey: _rootNavigatorKey,
  //       path: '/profile',
  //       pageBuilder: (_, state) => SlideRoute(
  //         key: state.pageKey,
  //         beginOffset: const Offset(0, 1),
  //         child: const ProfileScreen(),
  //       ),
  //     ),
  //     ShellRoute(
  //       navigatorKey: _shellNavigatorKey,
  //       builder: (context, state, child) => BaseScreen(
  //         child: child,
  //       ),
  //       // pageBuilder: (BuildContext context, GoRouterState state, child) =>
  //       //     FadeTransitionPage(
  //       //   key: UniqueKey(),
  //       //   child: BaseScreen(child: child),
  //       // ),
  //       routes: <RouteBase>[
  //         GoRoute(
  //           path: '/home',
  //           pageBuilder: (BuildContext context, GoRouterState state) {
  //             return FadeTransitionPage(
  //               key: state.pageKey,
  //               child: const HomeScreenContent(),
  //             );
  //           },
  //           routes: <RouteBase>[
  //             GoRoute(
  //               path: ':cmsId',
  //               builder: (BuildContext context, GoRouterState state) {
  //                 return Container(
  //                   color: Colors.greenAccent,
  //                   child: Center(
  //                     child: Text("home ${state.params['cmsId']}"),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //         GoRoute(
  //           path: '/products',
  //           pageBuilder: (BuildContext context, GoRouterState state) {
  //             return FadeTransitionPage(
  //               key: state.pageKey,
  //               child: const CategoriesScreen(),
  //             );
  //             // return ContentScreen(
  //             //   storageKey: mykey1,
  //             //   storageBucket: bucket1,
  //             // );
  //           },
  //           routes: <RouteBase>[
  //             GoRoute(
  //               path: ':cName',
  //               builder: (BuildContext context, GoRouterState state) {
  //                 return CategoriesScreen(category: '${state.params['cName']}');
  //               },
  //             ),
  //           ],
  //         ),
  //         GoRoute(
  //           path: '/diy',
  //           pageBuilder: (BuildContext context, GoRouterState state) {
  //             return FadeTransitionPage(
  //               key: state.pageKey,
  //               child: ContentScreen(
  //                 storageKey: mykey2,
  //                 storageBucket: bucket2,
  //               ),
  //             );
  //           },
  //         ),
  //         GoRoute(
  //           path: '/cart',
  //           pageBuilder: (_, state) {
  //             return FadeTransitionPage(
  //               key: state.pageKey,
  //               child: ContentScreen(
  //                 storageKey: mykey3,
  //                 storageBucket: bucket3,
  //               ),
  //             );
  //           },
  //         ),
  //         GoRoute(
  //           path: '/productList/:text',
  //           builder: (BuildContext context, GoRouterState state) {
  //             print('/productList pageKey = ${state.pageKey}');
  //             return SearchScreen(
  //               text: state.params['text'].toString(),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //     GoRoute(
  //       parentNavigatorKey: _rootNavigatorKey,
  //       path: '/product/:pId',
  //       builder: (BuildContext context, GoRouterState state) {
  //         return const ProductDetails();
  //       },
  //     ),
  //   ],
  // );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BAUHAUS',
      theme: BahagTheme.light,
      routerConfig: goRouter,
    );
  }
}
