import 'package:flutter/material.dart';

class FoodCategory {
  final String id;
  final String titleVi;
  final String titleEn;
  final String imageUrl;
  final Color color;

  const FoodCategory({
    required this.id,
    required this.titleVi,
    required this.titleEn,
    required this.imageUrl,
    this.color = Colors.orange,
  });

  String getTitle(String lang) {
    return lang == 'vi' ? titleVi : titleEn;
  }
}
