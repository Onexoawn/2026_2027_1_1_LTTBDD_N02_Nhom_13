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

  Recipe({
    required this.id,
    required this.categoryId,
    this.titleVi = '',
    this.titleEn = '',
  });

  String getTitle(String lang) => lang == 'vi' ? titleVi : titleEn;
}
