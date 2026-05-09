class NoInternetException implements Exception {
  final String message;

  NoInternetException([
    this.message = "No Internet Connection"
  ]);
}

class ServerException implements Exception {
  final String message;

  ServerException([
    this.message = 'Server error',
  ]);
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException([
    this.message = 'Request timeout',
  ]);
}

class UnKnownException implements Exception {
  final String message;

  UnKnownException([
    this.message = "UnKnown error"
  ]);
}