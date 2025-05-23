import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/to_do/to_do_tasks_bloc.dart';
import '../../blocs/to_do/to_do_tasks_state.dart';

class ToDoTasksScreen extends StatelessWidget {
  const ToDoTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ToDoTasksBloc(
        const ToDoTasksState.loading(),
      ),
      child: const Material(
        child: Center(
          child: Text('To Do Tasks'),
        ),
      ),
    );
  }
}
