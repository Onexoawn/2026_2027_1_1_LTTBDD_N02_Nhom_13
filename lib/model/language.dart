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
        duration: 45,
        difficultyVi: 'Dễ',
        difficultyEn: 'Easy',
        imageUrl: 'assets/image/MonChinh/PhoBo.jpg',
        ingredientsVi: [
          '500g Bánh phở',
          '300g Thịt bò tái/nạm',
          'Quế, hồi, thảo quả',
          'Hành lá, rau thơm',
        ],
        ingredientsEn: [
          '500g Rice noodles',
          '300g Sliced beef',
          'Cinnamon, star anise',
          'Green onions, herbs',
        ],
        stepsVi: [
          'Ninh xương bò cùng quế, hồi, thảo quả và gừng nướng trong 30 phút.',
          'Trần bánh phở qua nước sôi và xếp thịt bò thái mỏng lên trên.',
          'Chan nước dùng đang sôi vào bát, thêm hành lá và thưởng thức.',
        ],
        stepsEn: [
          'Simmer beef bones with roasted ginger and spices for 30 minutes.',
          'Blanch rice noodles in boiling water and top with thinly sliced beef.',
          'Pour boiling broth into the bowl, garnish with herbs and serve.',
        ],
        createdDate: DateTime(2026, 11, 08),
        isFavorite: true,
      ),
      Recipe(
        id: 'r2',
        categoryId: '1',
        titleVi: 'Bún Chả Truyền Thống',
        titleEn: 'Grilled Pork & Noodles (Bun Cha)',
        duration: 35,
        difficultyVi: 'Trung bình',
        difficultyEn: 'Medium',
        imageUrl: 'assets/image/MonChinh/BunChaHaNoi.jpg',
        ingredientsVi: [
          '400g Thịt ba chỉ & nạc vai',
          '500g Bún tươi',
          'Đu đủ xanh, cà rốt',
          'Nước mắm, tỏi, ớt',
        ],
        ingredientsEn: [
          '400g Pork belly & shoulder',
          '500g Vermicelli',
          'Green papaya, carrots',
          'Fish sauce, garlic, chili',
        ],
        stepsVi: [
          'Ướp thịt với hành tỏi, nước mắm, đường và tiêu trong 15 phút.',
          'Nướng chả trên than hoa hoặc nồi chiên không dầu cho vàng đều.',
          'Pha nước chấm chua ngọt kèm đu đủ muối và ăn cùng bún tươi.',
        ],
        stepsEn: [
          'Marinate pork with minced garlic, fish sauce, and sugar for 15 mins.',
          'Grill the pork until golden brown and fragrant.',
          'Prepare sweet and sour dipping sauce with pickled papaya and serve.',
        ],
        createdDate: DateTime(2026, 11, 08),
      ),
      Recipe(
        id: 'r3',
        categoryId: '2',
        titleVi: 'Đậu Hũ Sốt Cà Chua',
        titleEn: 'Tomato Sauce Tofu',
        duration: 20,
        difficultyVi: 'Dễ',
        difficultyEn: 'Easy',
        imageUrl: 'assets/image/MonChay/DauXotCaChua.jpg',
        ingredientsVi: [
          '3 bìa Đậu hũ non',
          '100g Nấm đông cô tươi',
          'Dầu hào chay, xì dầu',
          'Hành boa-rô',
        ],
        ingredientsEn: [
          '3 blocks Soft Tofu',
          '100g Fresh Shiitake mushrooms',
          'Vegan oyster sauce, soy sauce',
          'Leeks',
        ],
        stepsVi: [
          'Cắt đậu hũ thành miếng vuông vừa ăn, áp chảo sơ cho vàng mặt.',
          'Xào nấm đông cô với hành boa-rô và sốt dầu hào chay.',
          'Cho đậu hũ vào om nhẹ 5 phút cho thấm gia vị rồi tắt bếp.',
        ],
        stepsEn: [
          'Cut tofu into bite-sized cubes and pan-fry until golden.',
          'Stir-fry shiitake mushrooms with leeks and vegan oyster sauce.',
          'Simmer tofu in the mushroom sauce for 5 minutes and serve.',
        ],
        createdDate: DateTime(2026, 11, 08),
      ),
      Recipe(
        id: 'r4',
        categoryId: '3',
        titleVi: 'Bánh Flan Caramel Mềm Mịn',
        titleEn: 'Smooth Caramel Flan Cake',
        duration: 30,
        difficultyVi: 'Dễ',
        difficultyEn: 'Easy',
        imageUrl: 'assets/image/DoUong&Che/BanhFlan.jpg',
        ingredientsVi: [
          '4 quả Trứng gà',
          '300ml Sữa tươi không đường',
          '50g Đường trắng',
          '1 ống Vani',
        ],
        ingredientsEn: [
          '4 Eggs',
          '300ml Unsweetened fresh milk',
          '50g White sugar',
          '1 tsp Vanilla extract',
        ],
        stepsVi: [
          'Thắng đường với một chút nước để tạo lớp caramel vàng cánh gián ở đáy khuôn.',
          'Khuấy đều trứng với sữa ấm, lọc qua rây cho mịn rồi đổ vào khuôn.',
          'Hấp cách thủy lửa nhỏ trong 20 phút, để mát trước khi dùng.',
        ],
        stepsEn: [
          'Caramelize sugar with water and pour into the bottom of the molds.',
          'Whisk eggs with warm milk, strain through a sieve, and pour into molds.',
          'Steam on low heat for 20 minutes and chill before serving.',
        ],
        createdDate: DateTime(2026, 11, 08),
        isFavorite: true,
      ),
    ],
  );
}
