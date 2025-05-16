import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/domain/repositories/session_repository.dart';
import '../../../../core/domain/usescases/sign_out.dart';

class UserprofileScreen extends StatelessWidget {
  const UserprofileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => _signOut(context),
              icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    context.read<SignOutUseCase>().call();
  }
}
