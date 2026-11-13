import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/recipe.dart';
import 'recipe_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final String currentLang;
  final List<Recipe> favoriteRecipes;
  final Function(Recipe) onToggleFavorite;

  const FavoritesScreen({
    super.key,
    required this.currentLang,
    required this.favoriteRecipes,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final isVi = currentLang == 'vi';

    if (favoriteRecipes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 72, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            Text(
              isVi
                  ? 'Bạn chưa có món ăn yêu thích nào!\nHãy thả tim món ăn bạn thích nhé.'
                  : 'No favorite recipes yet!\nTap the heart icon on any dish to save it.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: favoriteRecipes.length,
      itemBuilder: (ctx, index) {
        final recipe = favoriteRecipes[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeDetailScreen(
                    recipe: recipe,
                    currentLang: currentLang,
                    onToggleFavorite: onToggleFavorite,
                  ),
                ),
              );
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                recipe.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 70,
                  height: 70,
                  color: Colors.orange.shade100,
                  child: const Icon(Icons.fastfood, color: Colors.deepOrange),
                ),
              ),
            ),
            title: Text(
              recipe.getTitle(currentLang),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                '${recipe.duration} ${isVi ? 'phút' : 'mins'} • ${recipe.getDifficulty(currentLang)} • ${DateFormat('dd-MM-yyyy').format(recipe.createdDate)}',
                style: const TextStyle(fontSize: 12.5),
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () => onToggleFavorite(recipe),
            ),
          ),
        );
      },
    );
  }
}
