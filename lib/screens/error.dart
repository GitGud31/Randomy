import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(this.error, {Key? key}) : super(key: key);
  final Exception error;

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_router.location),
            SelectableText(error.toString()),
            TextButton(
              child: const Text("Home"),
              onPressed: () => context.goNamed("home"),
            ),
          ],
        ),
      ),
    );
  }
}
