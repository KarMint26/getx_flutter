import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_patt/app/modules/recipes/controllers/recipe_controller.dart';

class RecipeView extends StatelessWidget {
  final int recipeId;

  RecipeView({required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final RecipeController detailController = Get.put(RecipeController());
    final Color primaryColor = const Color.fromARGB(255, 0, 111, 155);
    final Color secondColor = const Color(0xFFF8F9FA);

    // 🔥 Panggil data berdasarkan ID dari URL
    detailController.fetchRecipeById(recipeId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Recipe",
          style: TextStyle(color: secondColor),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: secondColor),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (detailController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            var recipe = detailController.recipeDetail;

            if (recipe.isEmpty) {
              return const Center(
                child: Text(
                  "Data tidak ditemukan!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }

            return SingleChildScrollView(
              child: Card(
                elevation: 4, // 🔥 Memberikan shadow yang lebih soft
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // 🔥 Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔥 Gambar Resep (Besar dan Rounded)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          recipe['photo_url'] ?? '',
                          height: 220, // 🔥 Lebih besar untuk menarik perhatian
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 220,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image,
                                size: 50, color: Colors.grey),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 🔥 Judul Resep dengan Gaya Menarik
                      Text(
                        recipe['title'] ?? 'No Title',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color:
                              Colors.deepOrange, // 🔥 Warna lebih eye-catching
                        ),
                      ),

                      const SizedBox(height: 10),

                      // 🔥 Informasi Tambahan (Tanggal, Likes, Comments)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dibuat: ${recipe['created_at'] ?? 'No Date'}",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.thumb_up,
                                  size: 16, color: Colors.green),
                              const SizedBox(width: 4),
                              Text(
                                "${recipe['likes_count']?.toString() ?? '0'}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.comment,
                                  size: 16, color: Colors.blue),
                              const SizedBox(width: 4),
                              Text(
                                "${recipe['comments_count']?.toString() ?? '0'}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      const Divider(),

                      // 🔥 Deskripsi
                      _buildSectionTitle("Deskripsi"),
                      Text(
                        recipe['description'] ?? 'Tidak ada deskripsi.',
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54),
                      ),

                      const SizedBox(height: 12),
                      const Divider(),

                      // 🔥 Cara Memasak
                      _buildSectionTitle("Cara Memasak"),
                      Text(
                        recipe['cooking_method'] ??
                            'Tidak ada instruksi memasak.',
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54),
                      ),

                      const SizedBox(height: 12),
                      const Divider(),

                      // 🔥 Bahan-bahan
                      _buildSectionTitle("Bahan-bahan"),
                      Text(
                        recipe['ingredients'] ??
                            'Tidak ada bahan yang terdaftar.',
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // 🔥 Widget untuk Judul Section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
