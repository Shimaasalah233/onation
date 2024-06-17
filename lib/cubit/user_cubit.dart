import 'dart:convert';
//import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter/foundation.dart';
import 'package:ONATION/cubit/user_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  static String _tokenKey = 'userToken';
  Future<void> _storeresetotp(String resetotp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userotp', resetotp);
  }

  Future<String?> _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail');
  }

  Future<void> _storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userToken', token);
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Method to sign up

  void signUp({
    required String userName,
    required String email,
    required String password,
    required String passwordConfirmed,
    required String phoneNumber,
  }) async {
    emit(RegisterLoadingState());

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      String requestBody = jsonEncode({
        'userName': userName,
        'phoneNumber': phoneNumber,
        'email': email,
        'password': password,
        'passwordConfirmed': passwordConfirmed,
      });

      try {
        http.Response response = await http.post(
          Uri.parse("https://projects.runasp.net/api/Account/register"),
          headers: {
            'Content-Type': 'application/json',
            'accept': '*/*',
          },
          body: requestBody,
        );
        print('Request Body: $requestBody');

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (response.statusCode == 200) {
          var responseBody = response.body;
          if (responseBody.contains('Account Added Successfully')) {
            await _saveUserInfo(userName, email, phoneNumber);
            emit(RegisterSuccessState(message: " تم التسجيل بنجاح"));
          } else if (responseBody.contains('status')) {
            var parsedResponse = jsonDecode(responseBody);
            if (parsedResponse['status'] == 200) {
              print(parsedResponse);
              await _saveUserInfo(userName, email, phoneNumber);
              emit(RegisterSuccessState(message: "تم التسجيل بنجاح "));
            } else {
              print(parsedResponse);
              emit(FailedToRegisterState(message: parsedResponse['message']));
            }
          } else {
            emit(FailedToRegisterState(message: responseBody));
          }
        } else {
          emit(FailedToRegisterState(
              message: " \t\t\t\t\t\t\t\t\tهناك خطأ ما\n"
                  "هذا اسم المستخدم موجود بالفعل\t"
                  "\t\tقم بتغيير اسم المستخدم و حاول مرة أخرى"));
        }
      } catch (error) {
        emit(FailedToRegisterState(message: "Failed to register: $error"));
      }
    } else {
      emit(FailedToRegisterState(message: "No internet connection"));
    }
  }

  Future<void> _saveUserInfo(
      String userName, String email, String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
    await prefs.setString('email', email);
    await prefs.setString('phoneNumber', phoneNumber);
  }

  Future<void> login({
    required String userName,
    required String password,
  }) async {
    emit(LoginLoadingState());

    try {
      final response = await http.post(
        Uri.parse('https://projects.runasp.net/api/Account/login'),
        headers: {
          'Content-Type': 'application/json',
          'accept': '*/*',
        },
        body: jsonEncode({
          'username': userName,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final token = responseBody['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        print('Token saved: $token');
        emit(LoginSuccessState(message: "تم التسجيل بنجاح "));
// Debug statement
      } else {
        emit(FailedToLoginState(
            message:
                "  يوجد خطأ في تسجيل الدخول تأكد انك تقوم بادخال اسم مستخدم وكلمة سر صالحين"));
      }
    } catch (error) {
      emit(FailedToLoginState(message: "Failed to login: $error"));
    }
  }

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoadingState());

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        if (token == null) {
          print("Token not found");
          return;
        }

        http.Response response = await http.delete(
          Uri.parse("https://projects.runasp.net/api/Account/delete"),
          headers: {
            'Authorization': 'Bearer $token',
            'accept': '*/*',
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 204) {
          emit(DeleteAccountSuccessState(message: "تم حذف الحساب "));
        } else {
          emit(FailedToDeleteAccountState(message: "لا يمكن حذف الحساب"));
        }
      } catch (error) {
        emit(FailedToDeleteAccountState(message: "لا يمكن حذف الحساب"));
      }
    } else {
      emit(FailedToDeleteAccountState(message: "No internet connection"));
    }
  }

  Future<void> addsuggestion({
    int? suggestionId,
    required String suggestionTitle,
    required String suggestionDescription,
  }) async {
    emit(AddsuggestionLoadingState());

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      String requestBody = jsonEncode({
        // 'suggestionId': suggestionId,
        'suggestionTitle': suggestionTitle,
        'suggestionDescription': suggestionDescription,
      });

      try {
        // Retrieve the token, assuming it's stored somewhere in your app

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        if (token == null) {
          print("Token not found");
          return;
        }
        http.Response response = await http.post(
          Uri.parse("https://projects.runasp.net/api/Suggestion/AddSuggestion"),
          headers: {
            'Content-Type': 'application/json',
            'accept': '*/*',
            'Authorization':
                'Bearer $token', // Include the token in the headers
          },
          body: requestBody,
        );
        print('Request Body: $requestBody');

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          emit(AddsuggestionSuccessState(message: "تم إضافة الإقتراح بنجاح"));
        } else {
          emit(FaliledtoAddsuggestionState(
              message: "يوجد خطأ ما الرجاء المحاولة مرة أخرى"));
        }
      } catch (error) {
        emit(FaliledtoAddsuggestionState(
            message: "Failed to add suggestion: $error"));
      }
    } else {
      emit(FaliledtoAddsuggestionState(message: "No internet connection"));
    }
  }

  Future<void> sendemail({
    required String email,
  }) async {
    emit(SendEmailLoadingState());

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      String requestBody = jsonEncode({
        'email': email,
      });

      try {
        // Retrieve the token, assuming it's stored somewhere in your app

        String encodedEmail = Uri.encodeComponent(email);
        http.Response response = await http.post(
          Uri.parse(
              "https://projects.runasp.net/api/Account/ForgotPassword?Email=$encodedEmail"),
          headers: {
            'Content-Type': 'application/json',
            'accept': '*/*',
            // Include the token in the headers
          },
          body: requestBody,
        );
        print('Request Body: $requestBody');

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          // Store the email
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', email);

          emit(SendEmailSuccessState(message: "تم إرسال الرمز بنجاح"));
        } else {
          emit(FaliledtoSendEmailState(
              message: "تعذر التعرف على هذا البريد الألكتروني"));
        }
      } catch (error) {
        emit(FaliledtoSendEmailState(message: "Failed to send code: $error"));
      }
    } else {
      emit(FaliledtoSendEmailState(message: "No internet connection"));
    }
  }

  Future<void> code({
    required String otp,
  }) async {
    emit(CodeLoadingState());

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');

      if (email == null) {
        emit(FaliledtoCodeState(
            message:
                "  تعذر التعرف على هذا البريد الألكتروني الرجاء المحاولة مرة أخرى"));
        return;
      }

      String requestBody = jsonEncode({'email': email, 'otp': otp});

      try {
        http.Response response = await http.post(
          Uri.parse("https://projects.runasp.net/api/Account/VerityOTP"),
          headers: {
            'Content-Type': 'application/json',
            'accept': '*/*',
            // Include the token in the headers
          },
          body: requestBody,
        );
        print('Request Body: $requestBody');

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          // Store the response body in SharedPreferences
          await prefs.setString('responseBody', response.body);

          emit(CodeSuccessState(message: "تم إدخال الرمز بنجاح"));
        } else {
          emit(FaliledtoCodeState(message: "عذراً هذا الكود غير صحيح"));
        }
      } catch (error) {
        emit(FaliledtoCodeState(message: "Failed to send code: $error"));
      }
    } else {
      emit(FaliledtoCodeState(message: "No internet connection"));
    }
  }

  Future<void> resetpass({
    required String password,
    required String confirmpassword,
  }) async {
    emit(ResetLoadingState());

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');
      String? responseBody = prefs.getString('responseBody');

      if (email == null || responseBody == null) {
        emit(FaliledtoCodeState(
            message: "No email or response body found. Please retry."));
        return;
      }

      String requestBody = jsonEncode({
        'NewPassword': password,
        'confirmPassword': confirmpassword,
        'email': email,
        'resetpassowToken': responseBody,
      });

      try {
        http.Response response = await http.post(
          Uri.parse("https://projects.runasp.net/api/Account/ResetPassword"),
          headers: {
            'Content-Type': 'application/json',
            'accept': '*/*',
            // Include the token in the headers if needed
          },
          body: requestBody,
        );
        print('Request Body: $requestBody');

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          emit(SuccesssresetState(message: "تم إعادة تعيين كلمة المرور بنجاح"));
        } else {
          emit(FailedtoresetState(message: "تعذر إعادة تعيين كلمة المرور"));
        }
      } catch (error) {
        emit(FailedtoresetState(message: "Failed to reset password: $error"));
      }
    } else {
      emit(FailedtoresetState(message: "No internet connection"));
    }
  }

  Future<void> removeToken() async {
    // Obtain shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      print("Token not found");
      return;
    }
    // Check if the token exists
    if (prefs.containsKey(_tokenKey)) {
      // Remove the token
      await prefs.remove(_tokenKey);
      print('Token removed successfully.');
    }
  }

  Future<void> logout() async {
    await removeToken();
    emit(LogoutSuccessState(message: "Logged out successfully."));
  }

  Future<void> resendCode() async {
    emit(Resendcodeloadingstate());

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');

      if (email == null) {
        emit(FaliledtoCodeState(message: "No email found. Please retry."));
        return;
      }

      String requestBody = jsonEncode({'email': email});

      try {
        String encodedEmail = Uri.encodeComponent(email);
        http.Response response = await http.post(
          Uri.parse(
              "https://projects.runasp.net/api/Account/ForgotPassword?Email=$encodedEmail"),
          headers: {
            'Content-Type': 'application/json',
            'accept': '*/*',
            // Include the token in the headers
          },
          body: requestBody,
        );
        print('Request Body: $requestBody');

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          // Store the response body in SharedPreferences
          await prefs.setString('responseBody', response.body);

          emit(ResendCodeSuccessState(message: "تم إعادة إرسال الرمز بنجاح"));
        } else {
          emit(FaliledtoresendCodeState(message: "فشل إعادة إرسال الرمز"));
        }
      } catch (error) {
        emit(FaliledtoresendCodeState(message: "Failed to send code: $error"));
      }
    } else {
      emit(FaliledtoresendCodeState(message: "No internet connection"));
    }
  }

  Future<void> fetchUserData() async {
    emit(FetchDataLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        print("Token not found");
        return;
      }
      final response = await http.get(
        Uri.parse('https://projects.runasp.net/api/Account/GetCurrentUser'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String userName = data['userName'];
        String email = data['email'];
        String phoneNumber = data['phoneNumber'];

        // Save user info in SharedPreferences
        await prefs.setString('userName', userName);
        await prefs.setString('email', email);
        await prefs.setString('phoneNumber', phoneNumber);

        emit(FetchDataSuccess(data: data));
        print('Data is fetched');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
      emit(FetchDataFailure(message: error.toString()));
    }
  }

  // Method to fetch data
  Future<void> fetchaboutusData() async {
    emit(FetchaboutusDataLoading());

    try {
      final response = await http.get(
        Uri.parse('https://projects.runasp.net/api/AboutUs/getAllAboutUs'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data2 = jsonDecode(response.body);

        emit(FetchaboutusDataSuccess(data2: data2));
        print('Data is fetched');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
      emit(FetchaboutusDataFailure(message: error.toString()));
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data3) async {
    final url = 'https://projects.runasp.net/api/Account/updateProfile';

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        print("Token not found");
        return;
      }
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(data3),
      );

      if (response.statusCode == 200) {
        emit(ProfileUpdateSuccess(message: 'تم تعديل البيانات بنجاح'));
      } else {
        emit(ProfileUpdateFailure(
            message: 'يوجد خطأ ما الرجاء المحاولة مرة أخرى'));
      }
    } catch (e) {
      emit(ProfileUpdateFailure(message: 'Error updating profile: $e'));
    }
  }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    // emit(ChangepassLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        print("Token not found");
        emit(PassUpdateFailure(message: 'Token not found'));
        return;
      }

      final url =
          Uri.parse('https://projects.runasp.net/api/Account/change-password');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final body = json.encode({
        'userPassword': currentPassword,
        'newPassword': newPassword,
      });

      print('Sending request to $url');
      print('Request headers: $headers');
      print('Request body: $body');

      final response = await http.put(
        url,
        headers: headers,
        body: body,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        emit(PassUpdateSuccess(message: 'تم تغيير كلمة السر بنجاح'));
      } else {
        emit(PassUpdateFailure(
          message: 'يوجد خطأ ما',
        ));
      }
    } catch (e) {
      print('Exception: $e');
      emit(PassUpdateFailure(message: 'Error updating password: $e'));
    }
  }

  /* Future<void> countriesData() async {
    emit(FetchcountriesDataLoading());

    try {
      final response = await http.get(
        Uri.parse('https://projects.runasp.net/api/Countries/getAllCountries'),
        headers: {
              'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data3 = jsonDecode(response.body);

        emit(FetchcountriesDataSuccess(data3: data3));
        print('Data is fetched');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
      emit(FetchcountriesDataFailure(message: error.toString()));
    }
  }*/

  Future<void> fetchCountries() async {
    emit(CountryLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        emit(CountryError('Token not found'));
        return;
      }

      final response = await http.get(
        Uri.parse('https://projects.runasp.net/api/Countries/getAllCountries'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        List<Country> countries =
            jsonResponse.map((country) => Country.fromJson(country)).toList();
        emit(CountryLoaded(countries));
      } else {
        emit(CountryError('Failed to load countries'));
      }
    } catch (e) {
      emit(CountryError('Error loading countries: $e'));
    }
  }

  Future<void> searchCountries(String? title) async {
    if (title == null || title.isEmpty) {
      await fetchCountries();
      return;
    }

    final url = Uri.parse(
        'https://projects.runasp.net/api/Countries/Search?title=$title');

    try {
      emit(CountryLoading());
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
        },
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Country> countries =
            data.map((json) => Country.fromJson(json)).toList();
        emit(CountryLoaded(countries));
      } else {
        emit(CountryError('Failed to load countries'));
      }
    } catch (e) {
      print('Error searching countries: $e');
      emit(CountryError(e.toString()));
    }
  }

  Future<List<Purpose>> fetchPurposes() async {
    try {
      final response = await http.get(
          Uri.parse('https://projects.runasp.net/api/Purpose/getAllPurpose'));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        List<Purpose> purposes =
            jsonResponse.map((purpose) => Purpose.fromJson(purpose)).toList();
        return purposes;
      } else {
        throw Exception('Failed to load purposes');
      }
    } catch (e) {
      throw Exception('Failed to load purposes: $e');
    }
  }

  Future<List<Place>> fetchPlaces() async {
    try {
      final response = await http.get(Uri.parse(
          'https://projects.runasp.net/api/TouristicPlace/getAllTouristicPlace'));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<Place> places =
            jsonResponse.map((json) => Place.fromJson(json)).toList();
        return places;
      } else {
        throw Exception('Failed to load places');
      }
    } catch (e) {
      throw Exception('Failed to load places: $e');
    }
  }

  Future<List<City>> fetchCities() async {
    try {
      final response = await http.get(Uri.parse(
          'https://projects.runasp.net/api/CountryCity/getAllCountryCityData'));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<City> cities =
            jsonResponse.map((json) => City.fromJson(json)).toList();
        return cities;
      } else {
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      throw Exception('Failed to load cities: $e');
    }
  }

  void countriesbycontient(String contintentname) async {
    emit(CountryLoading());
    try {
      final response = await http.get(Uri.parse(
          'https://projects.runasp.net/api/Countries/namesByContinent/$contintentname'));
      if (response.statusCode == 200) {
        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        List<dynamic> data = jsonDecode(response.body);
        List<Country> countries =
            data.map((country) => Country.fromJson(country)).toList();
        emit(CountryLoaded(countries));
      } else {
        emit(CountryError('Failed to load countries'));
      }
    } catch (e) {
      emit(CountryError(e.toString()));
    }
  }
}

class Country {
  final int countryId;
  final String countryName;
  final String countryContinent;
  final String countryDescription;
  final bool favoriteCountry;
  final List<String> countryImages;
  final List<String> countryGroups;

  Country({
    required this.countryId,
    required this.countryName,
    required this.countryContinent,
    required this.countryDescription,
    required this.favoriteCountry,
    required this.countryImages,
    required this.countryGroups,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryId: json['countryId'] ?? 0,
      countryName: json['countryName'] ?? '',
      countryContinent: json['countryContinent'] ?? '',
      countryDescription: json['countryDescription'] ?? '',
      favoriteCountry: json['favoriteCountry'] ?? false,
      countryImages: List<String>.from(json['countryImages'] ?? []),
      countryGroups: List<String>.from(json['countryGroups'] ?? []),
    );
  }
}

class Purpose {
  final int purposeId;
  final String purposeName;
  final String purposeType;

  Purpose({
    required this.purposeId,
    required this.purposeName,
    required this.purposeType,
  });

  factory Purpose.fromJson(Map<String, dynamic> json) {
    return Purpose(
      purposeId: json['purposeId'],
      purposeName: json['purposeName'],
      purposeType: json['purposeType'],
    );
  }
}

class Place {
  final int countryId;
  final String placeName;
  final String placeImage;

  Place(
      {required this.countryId,
      required this.placeName,
      required this.placeImage});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      countryId: json['countryId'],
      placeName: json['placeName'],
      placeImage: json['placeImage'],
    );
  }
}

class City {
  final int countryId;
  final String countryCity1;
  final String cityImage;

  City(
      {required this.countryId,
      required this.countryCity1,
      required this.cityImage});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      countryId: json['countryId'],
      countryCity1: json['countryCity1'],
      cityImage: json['cityImage'],
    );
  }
}
