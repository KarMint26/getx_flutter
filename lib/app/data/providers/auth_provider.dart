import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = 'https://recipe.incube.id/api';

  Future<bool> login(
      BuildContext context, String email, String password) async {
    try {
      print("[LOGIN] Sending request with email: $email");
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print("[LOGIN] Response: ${response.statusCode} - ${response.body}");
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = responseData['data']['token'];

        if (token != null && token.isNotEmpty) {
          await prefs.setString('access_token', token);
          print("[LOGIN] Token berhasil disimpan: $token");
          return true;
        } else {
          print("[LOGIN ERROR] Token tidak ditemukan di response!");
          Get.snackbar("Error", "Login gagal: Token tidak ditemukan.");
          return false;
        }
      } else {
        Get.snackbar("Error", responseData['message'] ?? 'Login gagal!');
        return false;
      }
    } catch (e) {
      print("[LOGIN ERROR] $e");
      Get.snackbar("Error", "Terjadi kesalahan saat login: $e");
      return false;
    }
  }

  Future<bool> register(
      BuildContext context, String name, String email, String password) async {
    try {
      print("[REGISTER] Sending request with name: $name, email: $email");
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      print("[REGISTER] Response: ${response.statusCode} - ${response.body}");
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', responseData['access_token']);
        await prefs.setString('refresh_token', responseData['refresh_token']);
        return true;
      } else {
        Get.snackbar("Error", responseData['message'] ?? 'Registrasi gagal!');
        return false;
      }
    } catch (e) {
      print("[REGISTER ERROR] $e");
      Get.snackbar("Error", "Terjadi kesalahan saat registrasi: $e");
      return false;
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<String?> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('refresh_token');

    if (token == null) {
      return "Tidak ada refresh token tersedia";
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/refresh-token/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print(
          "[REFRESH TOKEN] Response: ${response.statusCode} - ${response.body}");
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await prefs.setString('access_token', responseData['access_token']);
        return "Token berhasil diperbarui";
      } else {
        return "Gagal memperbarui token";
      }
    } catch (e) {
      print("[REFRESH TOKEN ERROR] $e");
      return "Error: $e";
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    print("[LOGOUT] Token removed, user logged out.");
  }
}
