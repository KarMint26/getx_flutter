import 'dart:convert';

RecipeModel recipeModelFromJson(String str) =>
    RecipeModel.fromJson(json.decode(str));

class RecipeModel {
  final int id;
  final String title;
  final String photoUrl;
  final int likesCount;
  final int commentsCount;
  final String description;
  final String cookingMethod;
  final String ingredients;
  final String createdAt;

  RecipeModel({
    required this.id,
    required this.title,
    required this.photoUrl,
    required this.likesCount,
    required this.commentsCount,
    required this.description,
    required this.cookingMethod,
    required this.ingredients,
    required this.createdAt,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        title: json["title"],
        photoUrl: json["photo_url"],
        likesCount: json["likes_count"],
        commentsCount: json["comments_count"],
        description: json["description"],
        cookingMethod: json["cooking_method"],
        ingredients: json["ingredients"],
        createdAt: json["created_at"],
      );
}
