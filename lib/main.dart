import 'package:flutter/material.dart';

import 'model/language.dart';
import 'model/category.dart';
import 'widget/home_screen.dart';

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

  void _handleSelectCategory(BuildContext context, FoodCategory category) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _currentLang == 'vi'
              ? 'Đã chọn danh mục: ${category.titleVi}'
              : 'Selected category: ${category.titleEn}',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe & Culinary Guide',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: Builder(
        builder: (ctx) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              AppData.tr('app_title', _currentLang),
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
                const Divider(height: 3),
              ],
            ),
          ),

          body: HomeScreen(
            currentLang: _currentLang,
            recipes: AppData.recipeBox.items,
            onSelectCategory: (cat) => _handleSelectCategory(ctx, cat),
          ),

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
        ),
      ),
    );
  }
}
