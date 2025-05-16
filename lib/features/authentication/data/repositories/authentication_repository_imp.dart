import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/models/user_model.dart';
import '../../../../core/either.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/typedefs.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {
  AuthenticationRepositoryImp({required GoTrueClient authClient})
      : _authClient = authClient;

  final GoTrueClient _authClient;
  @override
  FutureEither<Failure, UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authClient.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user!;
      return Either.right(
        UserModel.fromJson({
          'id': user.id,
          'name': user.userMetadata ?? {},
        }),
      );
    } catch (_) {
      return Either.left(Failure());
    }
  }

  @override
  FutureEither<Failure, UserModel> signUp({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final response = await _authClient.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );
      final user = response.user!;
      return Either.right(
        UserModel.fromJson({
          'id': user.id,
          'name': user.userMetadata ?? {},
        }),
      );
    } catch (_) {
      return Either.left(Failure());
    }
  }
}
