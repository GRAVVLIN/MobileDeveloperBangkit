import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';
import '../models/responses/auth_response_model.dart';
import 'auth_local_datasource.dart';

class AuthRemoteDatasource {
  // Register
  Future<Either<String, AuthResponseModel>> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      print('Register Response: ${response.statusCode} - ${response.body}'); // Debug print

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(AuthResponseModel.fromJson(response.body));
      } else {
        final errorResponse = json.decode(response.body);
        return Left(errorResponse['message'] ?? 'Registration failed');
      }
    } catch (e) {
      print('Register Error: $e'); // Debug print
      return Left('Error: ${e.toString()}');
    }
  }

  // Login
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return Right(AuthResponseModel.fromJson(response.body));
      } else {
        final errorResponse = json.decode(response.body);
        return Left(errorResponse['message'] ?? 'Login failed');
      }
    } catch (e) {
      return Left('Error: ${e.toString()}');
    }
  }

  //logout
  Future<Either<String, String>> logout() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/logout'),
        headers: {
          'Authorization': 'Bearer ${authData?.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await AuthLocalDatasource().removeAuthData();
        return Right('Logged out successfully');
      } else {
        return Left('Logout failed');
      }
    } catch (e) {
      return Left('Error: ${e.toString()}');
    }
  }

  //update fcm token
  Future<Either<String, String>> updateFcmToken(String fcmToken) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/update-fcm'),
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
      },
      body: {'fcm_id': fcmToken},
    );

    if (response.statusCode == 200) {
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }
}
