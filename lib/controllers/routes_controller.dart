import 'package:Randomy/screens/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/add_item.dart';
import '../screens/error.dart';

final routerProvider = Provider<GoRouter>(
  (_) => GoRouter(
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: [
      GoRoute(
        name: "home",
        path: "/",
        builder: (_, __) => HomeScreen(),
      ),
      GoRoute(
        name: "add-item",
        path: "/add-item",
        builder: (_, __) => AddItemScreen(),
      ),
    ],
    errorBuilder: (_, state) => ErrorScreen(state.error!),
  ),
);
