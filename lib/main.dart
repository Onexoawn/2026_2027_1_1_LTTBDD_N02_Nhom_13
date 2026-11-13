import 'package:flutter/material.dart';

import 'model/language.dart';
import 'model/category.dart';
import 'model/recipe.dart';
import 'widget/home_screen.dart';
import 'widget/recipe_list_screen.dart';
import 'widget/favorites_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _currentLang = 'vi';
  int _selectedIndex = 0;

  void _toggleLanguage() {
    setState(() {
      _currentLang = (_currentLang == 'vi') ? 'en' : 'vi';
    });
  }

  void _toggleFavorite(Recipe recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
    });
  }

  void _handleSelectCategory(BuildContext context, FoodCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeListScreen(
          category: category,
          currentLang: _currentLang,
          recipes: AppData.recipeBox.items,
          onToggleFavorite: _toggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoriteRecipes = AppData.recipeBox.items
        .where((r) => r.isFavorite)
        .toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe & Culinary Guide',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: Builder(
        builder: (ctx) {
          Widget currentBody;
          if (_selectedIndex == 1) {
            currentBody = FavoritesScreen(
              currentLang: _currentLang,
              favoriteRecipes: favoriteRecipes,
              onToggleFavorite: _toggleFavorite,
            );
          } else {
            currentBody = HomeScreen(
              currentLang: _currentLang,
              recipes: AppData.recipeBox.items,
              onSelectCategory: (cat) => _handleSelectCategory(ctx, cat),
            );
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                _selectedIndex == 1
                    ? AppData.tr('fav_tab', _currentLang)
                    : AppData.tr('app_title', _currentLang),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                TextButton(
                  onPressed: _toggleLanguage,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _currentLang == 'vi' ? 'VI | EN' : 'EN | VI',
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
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(color: Colors.deepOrange),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.restaurant,
                          color: Colors.white,
                          size: 42,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppData.tr('app_title', _currentLang),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.deepOrange),
                    title: Text(AppData.tr('home_tab', _currentLang)),
                    onTap: () {
                      setState(() => _selectedIndex = 0);
                      Navigator.pop(ctx);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.favorite,
                      color: Colors.deepOrange,
                    ),
                    title: Text(AppData.tr('fav_tab', _currentLang)),
                    onTap: () {
                      setState(() => _selectedIndex = 1);
                      Navigator.pop(ctx);
                    },
                  ),
                  const Divider(height: 3),
                  ListTile(
                    leading: const Icon(
                      Icons.language,
                      color: Colors.deepOrange,
                    ),
                    title: Text(
                      _currentLang == 'vi'
                          ? 'Chuyển sang Tiếng Anh'
                          : 'Switch to Vietnamese',
                    ),
                    onTap: () {
                      _toggleLanguage();
                      Navigator.pop(ctx);
                    },
                  ),
                ],
              ),
            ),
            body: currentBody,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: AppData.tr('home_tab', _currentLang),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite),
                  label: AppData.tr('fav_tab', _currentLang),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.add_circle_outline),
                  label: AppData.tr('add_tab', _currentLang),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.group),
                  label: AppData.tr('profile_tab', _currentLang),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
