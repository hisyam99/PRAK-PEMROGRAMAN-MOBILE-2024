import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: controller.categories.map((category) {
            return Obx(() => _buildCategoryItem(
                  category,
                  controller.selectedCategories.contains(category),
                ));
          }).toList(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            controller.updateCategories(); // Call update method
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text('Update'),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        controller.toggleCategorySelection(title); // Toggle selection on tap
      },
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue[100] : const Color(0xFFE5F6FA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
            child: Icon(
              _getIconForCategory(title),
              size: 40,
              color: const Color(0xFF0093B7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Smartphone':
        return Icons.phone_android;
      case 'Laptop':
        return Icons.laptop;
      case 'Computer':
        return Icons.computer;
      case 'Television':
        return Icons.tv;
      case 'Camera':
        return Icons.camera_alt;
      case 'Radio':
        return Icons.radio;
      case 'Tablet':
        return Icons.tablet;
      case 'Sound System':
        return Icons.speaker;
      default:
        return Icons.device_unknown;
    }
  }
}
