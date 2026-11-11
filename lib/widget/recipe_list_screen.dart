import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/category.dart';
import '../model/recipe.dart';
import '../model/language.dart';

class RecipeListScreen extends StatefulWidget {
  final FoodCategory category;
  final String currentLang;
  final List<Recipe> recipes;
  final Function(Recipe) onToggleFavorite;
  final Function(Recipe)? onSelectRecipe;

  const RecipeListScreen({
    super.key,
    required this.category,
    required this.currentLang,
    required this.recipes,
    required this.onToggleFavorite,
    this.onSelectRecipe,
  });

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  late String _lang;

  @override
  void initState() {
    super.initState();
    _lang = widget.currentLang;
  }

  @override
  Widget build(BuildContext context) {
    final categoryRecipes = widget.recipes
        .where((recipe) => recipe.categoryId == widget.category.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.category.getTitle(_lang),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _lang = (_lang == 'vi') ? 'en' : 'vi';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _lang == 'vi' ? 'VI | EN' : 'EN | VI',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: categoryRecipes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.no_meals_ouline,
                    size: 70,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _lang == 'vi'
                        ? 'Chưa có món ăn nào trong danh mục này!'
                        : 'No recipes found in this category!',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: categoryRecipes.length,
              itemBuilder: (ctx, index) {
                final recipe = categoryRecipes[index];

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      if (widget.onSelectRecipe != null) {
                        widget.onSelectRecipe!(recipe);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _lang == 'vi'
                                  ? 'Đang mở chi tiết: ${recipe.titleVi}'
                                  : 'Opening details: ${recipe.titleEn}',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              recipe.imageUrl,
                              width: 95,
                              height: 95,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 95,
                                height: 95,
                                color: Colors.orange.shade100,
                                child: const Icon(
                                  Icons.fastfood,
                                  color: Colors.deepOrange,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        recipe.getTitle(_lang),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.amber.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        widget.category.getTitle(_lang),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.brown,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),

                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${recipe.duration} ${_lang == 'vi' ? 'phút' : 'mins'}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_border,
                                          size: 16,
                                          color: Colors.deepOrange,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${recipe.getDifficulty(_lang)} • ${DateFormat('dd-MM-yyyy').format(recipe.createdDate)}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget.onToggleFavorite(recipe);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          recipe.isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: recipe.isFavorite
                                              ? Colors.red
                                              : Colors.grey,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
