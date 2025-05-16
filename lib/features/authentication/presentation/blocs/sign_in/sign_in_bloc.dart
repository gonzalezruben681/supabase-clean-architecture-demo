import 'package:flutter/foundation.dart';

import '../../../../../core/domain/entities/user.dart';
import '../../../../../core/either.dart';
import '../../../../../core/failures/failure.dart';
import '../../../../../core/presentation/blocs/session/session_bloc.dart';
import '../../../../../core/typedefs.dart';
import '../../../domain/repositories/authentication_repository.dart';
import 'sign_in_state.dart';

class SignInBloc extends ValueNotifier<SignInState> {
  SignInBloc(
    super.value, {
    required this.authenticationRepository,
    required this.sessionBloc,
  });

  final SessionBloc sessionBloc;
  final AuthenticationRepository authenticationRepository;

  void onEmailChanged(String email) {
    value = value.copyWith(
      email: email.trim(),
    );
  }

  void onPasswordChanged(String password) {
    value = value.copyWith(
      password: password.trim(),
    );
  }

  FutureEither<Failure, Usuario> submit() async {
    final result = authenticationRepository.signIn(
      email: value.email,
      password: value.password,
    );
    switch (result) {
      case Right(value: final user):
        sessionBloc.setUser(user);
      case _:
    }
    return result;
  }
}
