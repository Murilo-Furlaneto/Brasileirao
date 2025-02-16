class RequestExceptions implements Exception {
  final String message;

  RequestExceptions(this.message);

  @override
  String toString() {
    return 'RequestException(message: $message)';
  }
}
