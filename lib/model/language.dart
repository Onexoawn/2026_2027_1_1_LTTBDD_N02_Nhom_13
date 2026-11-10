import 'package:flutter/material.dart';

import 'category.dart';
import 'recipe.dart';

class AppData {
  static const Map<String, Map<String, String>> dictionary = {
    'vi': {
      'app_title': 'Sổ tay Ẩm thực',
      'search_hint': 'Tìm kiếm danh mục món ăn...',
      'chart_title': 'THỐNG KÊ TỶ LỆ MÓN ĂN TRONG SỔ TAY',
      'categories_title': 'Danh mục Ẩm thực',
      'dishes_count': 'món',
      'home_tab': 'Trang chủ',
      'fav_tab': 'Yêu thích',
      'add_tab': 'Thêm món',
      'profile_tab': 'Nhóm',
    },
    'en': {
      'app_title': 'Culinary Guide',
      'search_hint': 'Search food categories...',
      'chart_title': 'RECIPE DISTRIBUTION STATISTICS',
      'categories_title': 'Culinary Categories',
      'dishes_count': 'dishes',
      'home_tab': 'Home',
      'fav_tab': 'Favorites',
      'add_tab': 'Add',
      'profile_tab': 'Group Info',
    },
  };

  static String tr(String key, String lang) {
    return dictionary[lang]?[key] ?? key;
  }

  static const List<FoodCategory> categories = [
    FoodCategory(
      id: '1',
      titleVi: 'Món chính',
      titleEn: 'Main Dishes',
      imageUrl: 'assets/image/MonChinh.jpg',
      color: Colors.deepOrange,
    ),
    FoodCategory(
      id: '2',
      titleVi: 'Món chay',
      titleEn: 'Vegetarian',
      imageUrl: 'assets/image/MonChay.jpg',
      color: Colors.green,
    ),
    FoodCategory(
      id: '3',
      titleVi: 'Tráng miệng',
      titleEn: 'Desserts',
      imageUrl: 'assets/image/TrangMieng.jpg',
      color: Colors.amber,
    ),
    FoodCategory(
      id: '4',
      titleVi: 'Đặc sản Vùng cao',
      titleEn: 'Highland Specialties',
      imageUrl: 'assets/image/DacSanVungCao.jpg',
      color: Colors.brown,
    ),
    FoodCategory(
      id: '5',
      titleVi: 'Đồ uống & Chè',
      titleEn: 'Drinks & Sweet Soup',
      imageUrl: 'assets/image/DoUong&Che.jpg',
      color: Colors.blue,
    ),
    FoodCategory(
      id: '6',
      titleVi: 'Bánh truyền thống',
      titleEn: 'Traditional Cakes',
      imageUrl: 'assets/image/BanhTruyenThong.jpg',
      color: Colors.purple,
    ),
  ];

  static DataBox<Recipe> recipeBox = DataBox<Recipe>(
    items: [
      Recipe(
        id: 'r1',
        categoryId: '1',
        titleVi: 'Phở Bò Hà Nội',
        titleEn: 'Hanoi Beef Pho',
      ),
      Recipe(
        id: 'r2',
        categoryId: '1',
        titleVi: 'Bún Chả Truyền Thống',
        titleEn: 'Grilled Pork & Noodles (Bun Cha)',
      ),
      Recipe(
        id: 'r3',
        categoryId: '2',
        titleVi: 'Đậu Hũ Sốt Nấm Đông Cô',
        titleEn: 'Tofu with Shiitake Mushroom Sauce',
      ),
      Recipe(
        id: 'r4',
        categoryId: '3',
        titleVi: 'Bánh Flan Caramel Mềm Mịn',
        titleEn: 'Smooth Caramel Flan Cake',
      ),
    ],
  );
}
