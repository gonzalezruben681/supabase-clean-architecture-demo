import 'package:flutter/material.dart';
import 'core/data/models/repositories/websocket_repository_imp.dart';
import 'core/domain/repositories/push_notifications_repository.dart';
import 'core/domain/repositories/websocket_repository.dart';
import 'core/domain/usescases/sign_out.dart';
import 'core/presentation/blocs/session/session_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'core/data/models/repositories/session_repository_imp.dart';
import 'core/domain/repositories/session_repository.dart';
import 'core/presentation/blocs/session/session_state.dart';
import 'core/presentation/my_app.dart';
import 'features/authentication/data/repositories/authentication_repository_imp.dart';
import 'features/authentication/domain/repositories/authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await supabase.Supabase.initialize(
    url: const String.fromEnvironment('supabaseUrl'),
    anonKey: const String.fromEnvironment('supabaseAnonKey'),
  );
  final supabaseClient = supabase.Supabase.instance.client;
  runApp(
    MultiProvider(providers: [
      Provider<SessionRepository>(
        create: (_) => SessionRepositoryImp(
          authClient: supabaseClient.auth,
        ),
      ),
      Provider<AuthenticationRepository>(
        create: (_) => AuthenticationRepositoryImp(
          authClient: supabaseClient.auth,
        ),
      ),
      Provider<WebSocketRepository>(
        create: (_) => WebSocketRepositoryImp(),
      ),
      Provider<SignOutUseCase>(
        create: (context) => SignOutUseCaseImpl(
          sessionRepository: context.read<SessionRepository>(),
          pushNotificationsRepository: context.read<PushNotificationsRepository>(),
          webSocketRepository: context.read<WebSocketRepository>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => SessionBloc(
          SessionState.loading(),
          context.read<SessionRepository>(),
        ),
      ),
    ], child: const MyApp()),
  );
}
