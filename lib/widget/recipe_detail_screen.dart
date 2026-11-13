import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/recipe.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  final String currentLang;
  final Function(Recipe) onToggleFavorite;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
    required this.currentLang,
    required this.onToggleFavorite,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late String _lang;
  final Set<int> _checkedIngredients = {};
  final Set<int> _checkedSteps = {};

  @override
  void initState() {
    super.initState();
    _lang = widget.currentLang;
  }

  Widget _buildRecipeImage(String imageUrl) {
    final trimmed = imageUrl.trim();
    final fallback = Container(
      color: Colors.orange.shade100,
      child: const Icon(Icons.restaurant, size: 80, color: Colors.deepOrange),
    );

    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return Image.network(
        trimmed,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback,
      );
    }

    return Image.asset(
      trimmed,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => fallback,
    );
  }

  void _completeCooking() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.celebration, color: Colors.deepOrange, size: 28),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _lang == 'vi' ? 'Hoàn thành món ăn!' : 'Cooking Completed!',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          _lang == 'vi'
              ? 'Chúc mừng bạn đã thực hiện xong tất cả các bước cho món "${widget.recipe.getTitle(_lang)}". Chúc bạn ngon miệng!'
              : 'Congratulations! You have completed all steps for "${widget.recipe.getTitle(_lang)}". Enjoy your meal!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _checkedIngredients.clear();
                _checkedSteps.clear();
              });
              Navigator.pop(ctx);
            },
            child: Text(
              _lang == 'vi' ? 'Làm lại từ đầu' : 'Reset Checklist',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = widget.recipe.getIngredients(_lang);
    final steps = widget.recipe.getSteps(_lang);
    final bool isAllStepsDone =
        steps.isNotEmpty && _checkedSteps.length == steps.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 290,
                  width: double.infinity,
                  child: _buildRecipeImage(widget.recipe.imageUrl),
                ),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.55),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black87,
                        size: 18,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 16,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _lang = (_lang == 'vi') ? 'en' : 'vi';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white, width: 1.2),
                          ),
                          child: Text(
                            _lang == 'vi' ? 'VI | EN' : 'EN | VI',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        child: IconButton(
                          icon: Icon(
                            widget.recipe.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.recipe.isFavorite
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.onToggleFavorite(widget.recipe);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipe.getTitle(_lang),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 18,
                        color: Colors.deepOrange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.recipe.duration} ${_lang == 'vi' ? 'phút' : 'mins'}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.star_border,
                        size: 18,
                        color: Colors.deepOrange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.recipe.getDifficulty(_lang),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('dd-MM-yyyy')
                            .format(widget.recipe.createdDate),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Divider(thickness: 1),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _lang == 'vi'
                            ? 'Nguyên liệu chuẩn bị'
                            : 'Ingredients Checklist',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Text(
                        '${_checkedIngredients.length}/${ingredients.length}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color:
                              _checkedIngredients.length == ingredients.length
                              ? Colors.green
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _lang == 'vi'
                        ? 'Chạm vào từng nguyên liệu để đánh dấu đã chuẩn bị xong'
                        : 'Tap each ingredient to mark as prepared',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    color: Colors.orange.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ingredients.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3.6,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 4,
                            ),
                        itemBuilder: (ctx, index) {
                          final isChecked = _checkedIngredients.contains(index);
                          return InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              setState(() {
                                if (isChecked) {
                                  _checkedIngredients.remove(index);
                                } else {
                                  _checkedIngredients.add(index);
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  isChecked
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  size: 20,
                                  color: isChecked
                                      ? Colors.green
                                      : Colors.deepOrange,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    ingredients[index],
                                    style: TextStyle(
                                      fontSize: 13.5,
                                      color: isChecked
                                          ? Colors.grey.shade600
                                          : Colors.black87,
                                      decoration: isChecked
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _lang == 'vi' ? 'Các bước thực hiện' : 'Cooking Steps',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Text(
                        '${_checkedSteps.length}/${steps.length} ${_lang == 'vi' ? 'bước' : 'steps'}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isAllStepsDone
                              ? Colors.green
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _lang == 'vi'
                        ? 'Bấm vào từng bước khi bạn đã thực hiện xong'
                        : 'Tap each step as you complete it',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: steps.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 12, color: Colors.black12),
                    itemBuilder: (ctx, index) {
                      final isStepDone = _checkedSteps.contains(index);
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            if (isStepDone) {
                              _checkedSteps.remove(index);
                            } else {
                              _checkedSteps.add(index);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isStepDone
                                ? Colors.green.withOpacity(0.08)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundColor: isStepDone
                                  ? Colors.green
                                  : Colors.deepOrange,
                              foregroundColor: Colors.white,
                              radius: 15,
                              child: isStepDone
                                  ? const Icon(Icons.check, size: 16)
                                  : Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                            ),
                            title: Text(
                              steps[index],
                              style: TextStyle(
                                fontSize: 14.5,
                                height: 1.4,
                                color: isStepDone
                                    ? Colors.grey.shade600
                                    : Colors.black87,
                                decoration: isStepDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            trailing: Icon(
                              isStepDone
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: isStepDone
                                  ? Colors.green
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.shade300,
                        disabledForegroundColor: Colors.grey.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        elevation: isAllStepsDone ? 4 : 0,
                      ),
                      onPressed: isAllStepsDone ? _completeCooking : null,
                      icon: Icon(
                        isAllStepsDone
                            ? Icons.check_circle_outline
                            : Icons.playlist_add_check,
                      ),
                      label: Text(
                        isAllStepsDone
                            ? (_lang == 'vi'
                                  ? 'Hoàn thành món ăn!'
                                  : 'Complete Dish!')
                            : (_lang == 'vi'
                                  ? 'Hoàn thành món ăn (Đã xong ${_checkedSteps.length}/${steps.length} bước)'
                                  : 'Complete Dish (${_checkedSteps.length}/${steps.length} steps done)'),
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
