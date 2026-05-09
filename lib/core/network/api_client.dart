import 'package:dio/dio.dart';
import 'package:find_me_words/core/models/remote/word_model.dart';
import 'package:find_me_words/core/network/api_endpoints.dart';
import 'package:find_me_words/core/network/api_exceptions.dart';

class ApiClient {
  final Dio dio;

  const ApiClient(this.dio);

  Future<List<WordModel>> getWordDetails(String word) async {
    try {
      final response = await dio.get(ApiEndpoints.wordDetails(word));

      final data = response.data as List;

      return data.map((e) => WordModel.fromJson(e)).toList();

    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      if (e is Exception) rethrow;

      throw UnKnownException();
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        return NoInternetException();

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerException();

      case DioExceptionType.badResponse:
        return ServerException();  
      default:
        return UnKnownException();
    }
  }
}