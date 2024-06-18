import 'package:content_generator_front/services/api_service.dart';
import 'package:content_generator_front/services/cache_service.dart';
import 'package:dio/dio.dart';

class AuthService {
  static Future<void> register(
      {required String fullName,
      required String username,
      required String password}) async {
    try {
      await ApiService.postData(path: '/api/users/', data: {
        "username": username,
        "password": password,
        "fullname": fullName,
      });
    } on DioException catch (e) {
      print(e.response!.data);
      rethrow;
    }
  }

  static Future<void> login(
      {required String username, required String password}) async {
    try {
      Response? response =
          await ApiService.postData(path: '/api/token/login/', data: {
        "username": username,
        "password": password,
      });

      String token = "Token ${response!.data["auth_token"]}";
      await CacheService.setString(key: "token", value: token);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logout() async {
    try {
      await ApiService.postAuthorized(path: '/api/token/logout/');
      await CacheService.clearData();
    } catch (e) {
      rethrow;
    }
  }
}
