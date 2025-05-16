
import '../../../either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/repositories/session_repository.dart';
import '../../../failures/session_failure.dart';
import '../../../typedefs.dart';
import '../user_model.dart';

class SessionRepositoryImp implements SessionRepository {
  SessionRepositoryImp({required GoTrueClient authClient})
      : _authClient = authClient;

  final GoTrueClient _authClient;

  @override
  FutureEither<SessionFailure, UserModel> getCurrentAuthenticatedUser() async {
    final user = _authClient.currentUser;

    if(user == null) {
      return Either.left( SessionFailure());
    
    }
    return Either.right(
      UserModel.fromJson( 
        {
          'id': user.id,
          'name': user.userMetadata?? {},
        }
      ),
    );
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
