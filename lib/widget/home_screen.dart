import 'package:flutter/material.dart';

import '../model/category.dart';
import '../model/recipe.dart';
import '../model/language.dart';

class HomeScreen extends StatefulWidget {
  final String currentLang;
  final List<Recipe> recipes;
  final Function(FoodCategory) onSelectCategory;

  const HomeScreen({
    super.key,
    required this.currentLang,
    required this.recipes,
    required this.onSelectCategory,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';

  int _countRecipesInCategory(String categoryId) {
    return widget.recipes.where((r) => r.categoryId == categoryId).length;
  }

  @override
  Widget build(BuildContext context) {
    final filteredCategories = AppData.categories.where((cat) {
      final title = cat.getTitle(widget.currentLang).toLowerCase();
      return title.contains(_searchKeyword.toLowerCase());
    }).toList();

    final int c1Count = _countRecipesInCategory('1') + 1;
    final int c2Count = _countRecipesInCategory('2') + 1;
    final int c3Count = _countRecipesInCategory('3') + 1;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _searchKeyword = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.deepOrange,
                  ),
                  suffixIcon: _searchKeyword.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchKeyword = '';
                            });
                          },
                        )
                      : null,
                  hintText: AppData.tr('search_hint', widget.currentLang),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 14),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppData.tr('chart_title', widget.currentLang),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 28,
                        child: Row(
                          children: [
                            Expanded(
                              flex: c1Count,
                              child: Container(
                                color: Colors.deepOrange,
                                alignment: Alignment.center,
                                child: Text(
                                  widget.currentLang == 'vi'
                                      ? 'Món chính'
                                      : 'Main',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: c2Count,
                              fit: FlexFit.tight,
                              child: Container(
                                color: Colors.green,
                                alignment: Alignment.center,
                                child: Text(
                                  widget.currentLang == 'vi'
                                      ? 'Món chay'
                                      : 'Vegan',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: c3Count,
                              child: Container(
                                color: Colors.amber.shade700,
                                alignment: Alignment.center,
                                child: Text(
                                  widget.currentLang == 'vi'
                                      ? 'Tráng miệng'
                                      : 'Dessert',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            Text(
              AppData.tr('categories_title', widget.currentLang),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredCategories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.92,
              ),
              itemBuilder: (ctx, index) {
                final category = filteredCategories[index];
                final dishCount = _countRecipesInCategory(category.id);

                return InkWell(
                  onTap: () => widget.onSelectCategory(category),
                  borderRadius: BorderRadius.circular(16),
                  child: Card(
                    elevation: 4,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          category.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: category.color.withOpacity(0.25),
                            child: Icon(
                              Icons.restaurant_menu,
                              size: 48,
                              color: category.color,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.75),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '$dishCount ${AppData.tr('dishes_count', widget.currentLang)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 10,
                          right: 10,
                          child: Text(
                            category.getTitle(widget.currentLang),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
