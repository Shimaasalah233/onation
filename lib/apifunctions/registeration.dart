import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<bool> signUp(String userName, String email, String password,
      String passwordConfirmed, String phoneNumber) async {
    try {
      // Make a POST request to the sign-up endpoint
      final response = await _dio.post(
        'https://onationapi.runasp.net/api/Account/register',
        data: {
          'userName': userName,
          'email': email,
          'password': password,
          'passwordConfirmed': passwordConfirmed,
          'phoneNumber': phoneNumber,
        },
      );

      // If the request is successful (status code 200), return true
      if (response.statusCode == 200) {
        return true;
      } else {
        // If there's an error, print the error message and return false
        print('Error during sign-up: ${response.data}');
        return false;
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during sign-up: $e');
      return false;
    }
  }
}
