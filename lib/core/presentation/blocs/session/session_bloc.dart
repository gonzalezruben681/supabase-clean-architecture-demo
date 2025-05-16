import 'package:flutter/foundation.dart';
import '../../../domain/entities/user.dart';
import '../../../either.dart';
import '../../../domain/repositories/session_repository.dart';
import 'session_state.dart';

class SessionBloc extends ValueNotifier<SessionState> {
  SessionBloc(super.value, this._sessionRepository);

  final SessionRepository _sessionRepository;

  Future<void> init() async {
    final result = await _sessionRepository.getCurrentAuthenticatedUser();
    switch (result) {
      case Left():
        value = SessionState.loaded(null);

      case Right(
          value: final user
        ): // Right(value: final user ) el derecho es el valor de la clase y ese puede nombrar value: final user       value = SessionState.loaded(user);
        value = SessionState.loaded(user);
    }
  }

  void setUser(Usuario user) {
    value = SessionState.loaded(user);
  }
}
