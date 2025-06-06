import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/either.dart';
import '../../../../../core/presentation/blocs/session/session_bloc.dart';
import '../../../../../core/presentation/router/routes.dart';
import '../../../../../core/presentation/utils/validations_ext.dart';
import '../../../domain/repositories/authentication_repository.dart';
import '../../blocs/sign_up/sign_up_bloc.dart';
import '../../blocs/sign_up/sign_up_state.dart';
import '../../mixins/auth_form_mixin.dart';

class SignUpScreen extends StatelessWidget with AuthFormMixin {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpBloc(
        SignUpState(),
        context.read<AuthenticationRepository>(),
        context.read<SessionBloc>(),
      ),
      builder: (context, _) {
        final bloc = context.read<SignUpBloc>();
        return Scaffold(
          body: SafeArea(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: bloc.onEmailChanged,
                      validator: emailValidator,
                      decoration: const InputDecoration(
                        label: Text('Email'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: bloc.onNameChanged,
                      validator: nameValidator,
                      decoration: const InputDecoration(
                        label: Text('Name'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: bloc.onPasswordChanged,
                      validator: passwordValidator,
                      decoration: const InputDecoration(
                        label: Text('Password'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Consumer<SignUpBloc>(
                      builder: (context, bloc, __) {
                        final state = bloc.value;

                        return MaterialButton(
                          color: Colors.blue,
                          onPressed: state.email.isValidEmail &&
                                  state.password.isValidPassword &&
                                  state.name.isValidName
                              ? () => _submit(context)
                              : null,
                          child: const Text('Sign Up'),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _submit(BuildContext context) async {
    final result = await context.read<SignUpBloc>().submit();
    if (!context.mounted) {
      return;
    }
    switch (result) {
      case Right():
        const HomeRoute().go(context);
      case Left():
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error'),
          ),
        );
    }
  }
}