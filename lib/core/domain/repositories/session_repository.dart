import '../../failures/session_failure.dart';
import '../../typedefs.dart';
import '../entities/user.dart';

abstract interface class SessionRepository {
  FutureEither<SessionFailure, Usuario> getCurrentAuthenticatedUser();
  Future<void> signOut();
}
