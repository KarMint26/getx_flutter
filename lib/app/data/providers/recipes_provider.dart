import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:getx_patt/app/data/providers/auth_provider.dart';

class RecipeService {
  final String baseUrl = 'https://recipe.incube.id/api';

  Future<List> getAllRecipe() async {
    final token = await AuthService().getToken();
    if (token == null) {
      print("Error: No token found");
      return [];
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/recipes'),
        headers: {'Authorization': 'Bearer $token'},
      );

      print("[GET ALL RECIPES] Full Response: ${response.body}");
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData is Map<String, dynamic>) {
        var extractedData = responseData['data']['data'];

        if (extractedData is List) {
          print("[DEBUG] Loaded ${extractedData.length} recipes");
          return extractedData;
        } else {
          print("Error: `data['data']` is not a List - ${response.body}");
          return [];
        }
      } else {
        print("Error: Invalid response format - ${response.body}");
        return [];
      }
    } catch (e) {
      print("Error fetching recipes: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>?> getRecipeById(int id) async {
    final token = await AuthService().getToken();
    if (token == null) {
      print("Error: No token found");
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/recipes/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );

      print("[GET RECIPE] Response: ${response.statusCode} - ${response.body}");
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData is Map<String, dynamic>) {
        var extractedData = responseData['data'];
        return extractedData;
      } else {
        print("Error: Failed to fetch recipe details");
        return null;
      }
    } catch (e) {
      print("Error fetching recipe details: $e");
      return null;
    }
  }
}
