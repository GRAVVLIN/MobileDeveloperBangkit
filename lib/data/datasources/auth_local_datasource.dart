import 'package:shared_preferences/shared_preferences.dart';

import '../models/responses/auth_response_model.dart';
import '../../core/utils/jwt_helper.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    //save auth data to local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', authResponseModel.toJson());
    
    // Save username from token
    if (authResponseModel.token != null) {
      final username = JwtHelper.getUsernameFromToken(authResponseModel.token);
      if (username != null) {
        await prefs.setString('username', username);
      }
    }
  }

  Future<void> removeAuthData() async {
    //remove auth data from local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  Future<AuthResponseModel?> getAuthData() async {
    //get auth data from local storage
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');
    if (authData != null) {
      return AuthResponseModel.fromJson(authData);
    } else {
      return null;
    }
  }

  Future<bool> isAuth() async {
    //check if user is authenticated
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');
    if (authData != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }
}
