class DataBox<T> {
  List<T> items;
  DataBox({required this.items});
  int get count => items.length;
}

class Recipe {
  final String id;
  final String categoryId;
  final String titleVi;
  final String titleEn;
  final int duration;
  final String difficultyVi;
  final String difficultyEn;
  final String imageUrl;
  final List<String> ingredientsVi;
  final List<String> ingredientsEn;
  final List<String> stepsVi;
  final List<String> stepsEn;
  final DateTime createdDate;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.categoryId,
    required this.titleVi,
    required this.titleEn,
    required this.duration,
    required this.difficultyVi,
    required this.difficultyEn,
    required this.imageUrl,
    required this.ingredientsVi,
    required this.ingredientsEn,
    required this.stepsVi,
    required this.stepsEn,
    required this.createdDate,
    this.isFavorite = false,
  });

  String getTitle(String lang) => lang == 'vi' ? titleVi : titleEn;
  String getDifficulty(String lang) =>
      lang == 'vi' ? difficultyVi : difficultyEn;
  List<String> getIngredients(String lang) =>
      lang == 'vi' ? ingredientsVi : ingredientsEn;
  List<String> getSteps(String lang) => lang == 'vi' ? stepsVi : stepsEn;
}
