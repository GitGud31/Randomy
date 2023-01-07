import 'package:Randomy/screens/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/add_item.dart';
import '../screens/error.dart';

const String HOME = 'home';
const String ADD_ITEM = 'add-item';

final routerProvider = Provider<GoRouter>(
  (_) => GoRouter(
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: [
      GoRoute(
        name: HOME,
        path: "/",
        builder: (_, __) => HomeScreen(),
      ),
      GoRoute(
        name: ADD_ITEM,
        path: "/$ADD_ITEM",
        builder: (_, __) => AddItemScreen(),
      ),
    ],
    errorBuilder: (_, state) => ErrorScreen(state.error!),
  ),
);
