import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'blocs/session/session_bloc.dart';
import 'blocs/session/session_state.dart';
import 'router/routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  Future<void> _init() async {
    final bloc = context.read<SessionBloc>();
    await bloc.init();
    _router = GoRouter(
      navigatorKey: rootNavigationKey,
        initialLocation: switch (bloc.value) {
          SessionLoadedState state =>
            state.user == null ? SingInRoute.path : ToDoRoute.path,
          _ => SingInRoute.path,
        },
        routes: $appRoutes);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _init(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MaterialApp.router(
              routerConfig: _router,
              darkTheme: ThemeData.dark(),
              themeMode: ThemeMode.dark,
            ),
          );
        });
  }
}
