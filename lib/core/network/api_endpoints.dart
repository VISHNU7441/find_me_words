class ApiEndpoints {
  static const String baseUrl = 'https://api.dictionaryapi.dev/api/v2';

  static String wordDetails(String word) {
    return '/entries/en/$word';
  }
}