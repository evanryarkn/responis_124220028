import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  final String _baseUrl = "https://www.themealdb.com/api/json/v1/1/";

  Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse("${_baseUrl}categories.php"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['categories'];
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<List<dynamic>> fetchMealsByCategory(String category) async {
    final response =
        await http.get(Uri.parse("${_baseUrl}filter.php?c=$category"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['meals'];
    } else {
      throw Exception("Failed to load meals");
    }
  }

  Future<dynamic> fetchMealDetail(String mealId) async {
    final response =
        await http.get(Uri.parse("${_baseUrl}lookup.php?i=$mealId"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['meals'][0]; 
    } else {
      throw Exception("Failed to load meal detail");
    }
  }
}
