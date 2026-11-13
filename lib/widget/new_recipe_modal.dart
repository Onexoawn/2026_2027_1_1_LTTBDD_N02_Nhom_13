import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/language.dart';
import '../model/recipe.dart';

class NewRecipeModal extends StatefulWidget {
  final String currentLang;
  final Function(Recipe) onAddRecipe;

  const NewRecipeModal({
    super.key,
    required this.currentLang,
    required this.onAddRecipe,
  });

  @override
  State<NewRecipeModal> createState() => _NewRecipeModalState();
}

class _NewRecipeModalState extends State<NewRecipeModal> {
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  final _imageUrlController = TextEditingController();

  String _selectedCategoryId = '';
  String _selectedDifficultyVi = 'Dễ';
  String _selectedLocalImage = '';
  DateTime _currentDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != _currentDate) {
      setState(() {
        _currentDate = pickedDate;
      });
    }
  }

  Widget _buildPreviewImage(String selectedCatImage) {
    final enteredUrl = _imageUrlController.text.trim();

    if (_selectedLocalImage.isEmpty && enteredUrl.isNotEmpty) {
      return Image.network(
        enteredUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey.shade200,
          child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
        ),
      );
    }

    final localPath = _selectedLocalImage.isNotEmpty
        ? _selectedLocalImage
        : selectedCatImage;

    return Image.asset(
      localPath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.grey.shade200,
        child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
      ),
    );
  }

  void submitData() {
    final enteredTitle = _titleController.text.trim();
    final enteredDuration = int.tryParse(_durationController.text.trim()) ?? 0;

    if (enteredTitle.isEmpty || enteredDuration <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            widget.currentLang == 'vi'
                ? 'Vui lòng nhập tên món và thời gian nấu (> 0 phút)!'
                : 'Please enter a valid dish name and cooking time (> 0 mins)!',
          ),
        ),
      );
      return;
    }

    final List<String> ingredientsList =
        _ingredientsController.text.trim().isEmpty
        ? (widget.currentLang == 'vi'
              ? ['Nguyên liệu tươi theo mùa', 'Gia vị cơ bản']
              : ['Fresh seasonal ingredients', 'Basic seasonings'])
        : _ingredientsController.text
              .split(RegExp(r'[,\n]'))
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();

    final List<String> stepsList = _stepsController.text.trim().isEmpty
        ? (widget.currentLang == 'vi'
              ? [
                  'Sơ chế nguyên liệu sạch sẽ.',
                  'Chế biến trên lửa vừa và trình bày ra đĩa.',
                ]
              : [
                  'Prepare and wash all ingredients.',
                  'Cook over medium heat and serve on a plate.',
                ])
        : _stepsController.text
              .split(RegExp(r'[.\n]'))
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();

    final selectedCat = AppData.categories.firstWhere(
      (c) => c.id == _selectedCategoryId,
      orElse: () => AppData.categories.first,
    );

    final String enteredUrl = _imageUrlController.text.trim();
    final String finalImageUrl = _selectedLocalImage.isNotEmpty
        ? _selectedLocalImage
        : (enteredUrl.isNotEmpty ? enteredUrl : selectedCat.imageUrl);

    final String difficultyEn = _selectedDifficultyVi == 'Dễ'
        ? 'Easy'
        : (_selectedDifficultyVi == 'Trung bình' ? 'Medium' : 'Hard');

    final newRecipe = Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      categoryId: _selectedCategoryId,
      titleVi: enteredTitle,
      titleEn: enteredTitle,
      duration: enteredDuration,
      difficultyVi: _selectedDifficultyVi,
      difficultyEn: difficultyEn,
      imageUrl: finalImageUrl,
      ingredientsVi: ingredientsList,
      ingredientsEn: ingredientsList,
      stepsVi: stepsList,
      stepsEn: stepsList,
      createdDate: _currentDate,
    );

    widget.onAddRecipe(newRecipe);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isVi = widget.currentLang == 'vi';

    final selectedCat = AppData.categories.firstWhere(
      (c) => c.id == _selectedCategoryId,
      orElse: () => AppData.categories.first,
    );

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 16,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              isVi ? 'Thêm Công Thức Mới' : 'Add New Recipe',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
              decoration: InputDecoration(
                labelText: isVi ? 'Nhập tên món ăn (*)' : 'Enter dish name (*)',
                prefixIcon: const Icon(
                  Icons.restaurant_menu,
                  color: Colors.deepOrange,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              decoration: InputDecoration(
                labelText: isVi
                    ? 'Nhập thời gian nấu - phút (*)'
                    : 'Enter cooking time - mins (*)',
                prefixIcon: const Icon(
                  Icons.timer_outlined,
                  color: Colors.deepOrange,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategoryId,
                    decoration: InputDecoration(
                      labelText: isVi ? 'Danh mục' : 'Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                    items: AppData.categories.map((cat) {
                      return DropdownMenuItem(
                        value: cat.id,
                        child: Text(
                          cat.getTitle(widget.currentLang),
                          style: const TextStyle(fontSize: 13),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedCategoryId = val);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: _selectedDifficultyVi,
                    decoration: InputDecoration(
                      labelText: isVi ? 'Độ khó' : 'Level',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'Dễ',
                        child: Text(
                          isVi ? 'Dễ' : 'Easy',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Trung bình',
                        child: Text(
                          isVi ? 'Vừa' : 'Medium',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Khó',
                        child: Text(
                          isVi ? 'Khó' : 'Hard',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedDifficultyVi = val);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _ingredientsController,
              decoration: InputDecoration(
                labelText: isVi
                    ? 'Nguyên liệu (ngăn cách bởi dấu phẩy)'
                    : 'Ingredients (comma separated)',
                prefixIcon: const Icon(
                  Icons.shopping_basket_outlined,
                  color: Colors.deepOrange,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _stepsController,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: isVi
                    ? 'Cách làm từng bước (ngăn cách bởi dấu chấm)'
                    : 'Cooking steps (separated by dot)',
                hintText: isVi
                    ? 'VD: Sơ chế nguyên liệu. Xào chín trên lửa vừa. Trình bày ra đĩa.'
                    : 'Ex: Wash ingredients. Stir-fry on medium heat. Serve on a plate.',
                prefixIcon: const Icon(
                  Icons.format_list_numbered,
                  color: Colors.deepOrange,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _selectedLocalImage,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: isVi
                    ? 'Chọn ảnh có sẵn trong Local (Image.asset)'
                    : 'Select local image (Image.asset)',
                prefixIcon: const Icon(
                  Icons.photo_library_outlined,
                  color: Colors.deepOrange,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
              items: AppData.localRecipeImages.map((img) {
                return DropdownMenuItem<String>(
                  value: img['path'] ?? '',
                  child: Text(
                    isVi ? (img['labelVi'] ?? '') : (img['labelEn'] ?? ''),
                    style: const TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedLocalImage = val;
                    if (val.isNotEmpty) {
                      _imageUrlController.clear();
                    }
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _imageUrlController,
                    keyboardType: TextInputType.url,
                    onChanged: (val) {
                      setState(() {
                        if (val.trim().isNotEmpty) {
                          _selectedLocalImage = '';
                        }
                      });
                    },
                    decoration: InputDecoration(
                      labelText: isVi
                          ? 'Hoặc dán link URL ảnh mạng (Image.network)'
                          : 'Or paste web image URL (Image.network)',
                      hintText: 'https://...',
                      prefixIcon: const Icon(
                        Icons.link,
                        color: Colors.deepOrange,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 54,
                    height: 54,
                    child: _buildPreviewImage(selectedCat.imageUrl),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Text(
              'DatePicker',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 6),
            InkWell(
              onTap: () => _selectDate(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${isVi ? 'Ngày đăng: ' : 'Created Date: '}${DateFormat('dd-MM-yyyy').format(_currentDate)}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Icon(Icons.calendar_month, color: Colors.deepOrange),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    isVi ? 'Hủy / Cancel' : 'Cancel',
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: submitData,
                  child: Text(
                    isVi ? 'Lưu / Save' : 'Save',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
