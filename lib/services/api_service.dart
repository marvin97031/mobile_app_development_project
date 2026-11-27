import 'dart:convert';

import 'package:http/http.dart' as http;

class Meal {
  const Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String imageUrl;

  /// Uses the same keys as TheMealDB, so it also reads locally saved data.
  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json['idMeal'] as String,
        name: json['strMeal'] as String? ?? '',
        category: json['strCategory'] as String? ?? '',
        area: json['strArea'] as String? ?? '',
        instructions: json['strInstructions'] as String? ?? '',
        imageUrl: json['strMealThumb'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'idMeal': id,
        'strMeal': name,
        'strCategory': category,
        'strArea': area,
        'strInstructions': instructions,
        'strMealThumb': imageUrl,
      };
}

/// External API integration: https://www.themealdb.com/api.php
class ApiService {
  Future<List<Meal>> searchMeals(String query) async {
    final uri = Uri.https('www.themealdb.com', '/api/json/v1/1/search.php', {
      's': query,
    });
    final response = await http.get(uri).timeout(const Duration(seconds: 15));
    if (response.statusCode != 200) {
      throw Exception('Server error: ${response.statusCode}');
    }
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final meals = body['meals'] as List<dynamic>? ?? [];
    return meals
        .map((m) => Meal.fromJson(m as Map<String, dynamic>))
        .toList();
  }
}
