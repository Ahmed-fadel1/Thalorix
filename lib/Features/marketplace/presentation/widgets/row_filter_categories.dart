import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/marketplace/domain/entities/category_entity.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:toggle_switch/toggle_switch.dart';

class RowFilterCategories extends StatelessWidget {
  final List<CategoryEntity> categories;
  final int selectedIndex;
  final void Function(CategoryEntity? selectedCategory) onCategorySelected;

  const RowFilterCategories({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final labels = ['All', ...categories.map((c) => c.name)];
  final widths = [
  60.0,
  ...categories.map(
    (c) => (c.name.length * 8.0 + 40.0).clamp(90.0, 170.0),
  ),
];

    return Padding(
      padding: const  EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          const Icon(Icons.filter_list_rounded),
          const SizedBox(width: 4),
          const Text(
            'Filters',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        const SizedBox(width: 12),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ToggleSwitch(
                totalSwitches: labels.length,
                labels: labels,
                initialLabelIndex: selectedIndex,
                customWidths: widths,
                cornerRadius: 12,
                dividerColor: Colors.transparent,
                borderWidth: 0,
               dividerMargin: 0,
               // inactiveBgColor: Colors.transparent,
                activeBgColor: const [Color(0xFFB2D8D8)],
                activeFgColor: AppColors.iconbutton,
                inactiveFgColor: AppColors.iconbutton,
                inactiveBgColor: const Color(0xFFF4F4F4),
                onToggle: (index) {
                  if (index == 0) {
                    onCategorySelected(null);
                  } else if (index != null) {
                    onCategorySelected(categories[index - 1]);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
