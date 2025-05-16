import '../repositories/push_notifications_repository.dart';
import '../repositories/session_repository.dart';
import '../repositories/websocket_repository.dart';

abstract class SignOutUseCase {
  Future<void> call();
}

class SignOutUseCaseImpl implements SignOutUseCase {
  SignOutUseCaseImpl({
    required SessionRepository sessionRepository,
    required PushNotificationsRepository pushNotificationsRepository,
    required WebSocketRepository webSocketRepository,
  })  : _sessionRepository = sessionRepository,
        _pushNotificationsRepository = pushNotificationsRepository,
        _webSocketRepository = webSocketRepository;

  final SessionRepository _sessionRepository;
  final PushNotificationsRepository _pushNotificationsRepository;
  final WebSocketRepository _webSocketRepository;

  @override
  Future<void> call() async {
    await _sessionRepository.signOut();
    await _pushNotificationsRepository.removeToken();
    await _webSocketRepository.disconnect();
  }
}
