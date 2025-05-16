import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/domain/repositories/session_repository.dart';
import '../../../../core/domain/repositories/websocket_repository.dart';
import '../../../../core/domain/usescases/sign_out.dart';
import '../../../../core/presentation/router/routes.dart';

class DasHboardScaffold extends StatelessWidget {
  const DasHboardScaffold({
    super.key,
    required this.state,
    required this.child,
  });
  final GoRouterState state;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () => ProfileRoute().push(context),
              child: const CircleAvatar()),
          const SizedBox(width: 20),
        ],
      ),
      body: SafeArea(child: child),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          final path = DashboardRoutes.values[index].path;
          context.go(path);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.run_circle_rounded),
            label: 'In Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all_rounded),
            label: 'Finished',
          ),
        ],
      ),
    );
  }

  void _listenSession(BuildContext context) {
    context.read<SignOutUseCase>().call();
  }
}

enum DashboardRoutes {
  toDo(ToDoRoute.path),
  inProgress(InProgressRoute.path),
  finished(FinishedRoute.path);

  const DashboardRoutes(this.path);
  final String path;
}
