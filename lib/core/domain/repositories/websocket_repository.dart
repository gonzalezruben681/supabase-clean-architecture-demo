abstract interface class WebSocketRepository {
  Future<void> connect();
  Future<void> disconnect();
}