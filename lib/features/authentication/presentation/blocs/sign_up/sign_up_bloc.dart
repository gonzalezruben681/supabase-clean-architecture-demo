import 'package:flutter/foundation.dart';

import '../../../../../core/domain/entities/user.dart';
import '../../../../../core/either.dart';
import '../../../../../core/failures/failure.dart';
import '../../../../../core/presentation/blocs/session/session_bloc.dart';
import '../../../../../core/typedefs.dart';
import '../../../domain/repositories/authentication_repository.dart';
import 'sign_up_state.dart';

class SignUpBloc extends ValueNotifier<SignUpState> {
  SignUpBloc(super.value, this._authenticationRepository, this._sessionBloc);

  final AuthenticationRepository _authenticationRepository;
  final SessionBloc _sessionBloc;

  void onEmailChanged(String email) {
    value = value.copyWith(
      email: email.trim(),
    );
  }

  void onNameChanged(String name) {
    value = value.copyWith(
      name: name.trim(),
    );
  }

  void onPasswordChanged(String password) {
    value = value.copyWith(
      password: password.trim(),
    );
  }

  FutureEither<Failure, Usuario> submit() async {
    final result = await _authenticationRepository.signUp(
      email: value.email,
      name: value.name,
      password: value.password,
    );

    switch (result) {
      case Right(value: final user):
        _sessionBloc.setUser(user);
      case _:
        
    }
    return result;
  }
}
