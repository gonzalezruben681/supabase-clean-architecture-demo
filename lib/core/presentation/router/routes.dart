import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/authentication/presentation/screens/sign_in/sign_in_screen.dart';
import '../../../features/authentication/presentation/screens/sign_up/sign_up_screen.dart';
import '../../../features/dashboard/presentation/screens/finished/finished_tasks_screen.dart';
import '../../../features/dashboard/presentation/screens/in_progress/in_progress_tasks_screen.dart';
import '../../../features/dashboard/presentation/screens/to_do/to_do_tasks_screen.dart';
import '../../../features/dashboard/presentation/widgets/dashboard_scaffold.dart';
import '../../../features/user_profile/presentation/screens/user_profile_screen.dart';
part 'routes.g.dart';

final rootNavigationKey = GlobalKey<NavigatorState>();

@TypedGoRoute<SingInRoute>(
  path: SingInRoute.path,
)
class SingInRoute extends GoRouteData {
  const SingInRoute();
  static const String path = '/sign-in';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignInScreen();
  }
}

@TypedGoRoute<SingUpRoute>(
  path: SingUpRoute.path,
)
class SingUpRoute extends GoRouteData {
  const SingUpRoute();
  static const String path = '/sign-up';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignUpScreen();
  }
}

@TypedStatefulShellRoute<DashboardShellRoute>(
  branches: [
    TypedStatefulShellBranch(routes: [
      TypedGoRoute<ToDoRoute>(path: ToDoRoute.path),
      TypedGoRoute<InProgressRoute>(path: InProgressRoute.path),
      TypedGoRoute<FinishedRoute>(path: FinishedRoute.path),
    ]),
  ],
)
class DashboardShellRoute extends StatefulShellRouteData {
  const DashboardShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state,
      StatefulNavigationShell navigationShell) {
    return DasHboardScaffold(
      state: state,
      child: navigationShell,
    );
  }
}

class ToDoRoute extends GoRouteData {
  static const String path = '/todo';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ToDoTasksScreen();
  }
}

class InProgressRoute extends GoRouteData {
  static const String path = '/in-progress';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const InProgressTasksScreen();
  }
}

class FinishedRoute extends GoRouteData {
  static const String path = '/finished';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FinishedTasksScreen();
  }
}

@TypedGoRoute<ProfileRoute>(
  path: ProfileRoute.path,
)
class ProfileRoute extends GoRouteData {
  static const String path = '/profile';
  static final GlobalKey<NavigatorState> parentNavegatorKey = rootNavigationKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UserprofileScreen();
  }
}

@TypedGoRoute<HomeRoute>(
  path: HomeRoute.path,
)
class HomeRoute extends GoRouteData {
  const HomeRoute();
  static const String path = '/home';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Scaffold(
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
