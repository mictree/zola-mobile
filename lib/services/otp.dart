import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:zola/constants.dart' as constants;

const api = constants.api;
Dio dio = Dio();

Future<void> requestOtpResetPassword(String email) async {
  final response =
      await dio.post("$api/otp/forget-otp", data: {"email": email});

  if (response.statusCode == 200) {
    // If the server did return a successful response, parse the JSON.
    print("User info load");
  } else {
    // If the server did not return a successful response, throw an error.
    throw Exception('Failed to load data');
  }
}

Future<void> verifyOtp(String email) async {
  final response = await http.post(Uri.parse("$api/otp/verify"), headers: {
    "Content-Type": "application/json",
    "Accept": "*/*",
  }, body: {
    "email": email
  });

  if (response.statusCode == 200) {
    // If the server did return a successful response, parse the JSON.
    print("User info load");
  } else {
    // If the server did not return a successful response, throw an error.
    throw Exception('Failed to load data');
  }
}

Future<void> requestOtpRegister(String email) async {
  try {
    final body = jsonEncode({"email": email});
    final response = await http.post(Uri.parse("$api/otp/request-otp"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
        },
        body: body);

    if (response.statusCode == 200) {
      // If the server did return a successful response, parse the JSON.
      print("User info load");
    } else {
      // If the server did not return a successful response, throw an error.
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Request failed');
  }
}

Future<String> verifyRegisterOtp(String email, String otp) async {
  try {
    final body = jsonEncode({"email": email, "otp": otp});

    final response = await http.post(Uri.parse("$api/otp/verify-register"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
        },
        body: body);

    if (response.statusCode == 200) {
      // If the server did return a successful response, parse the JSON.
      return jsonDecode(response.body)["accessToken"];
    } else {
      // If the server did not return a successful response, throw an error.
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Request failed');
  }
}
