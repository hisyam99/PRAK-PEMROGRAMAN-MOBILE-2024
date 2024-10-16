import 'package:get/get.dart';

class CategoryController extends GetxController {
  // This is where you can define variables and methods to handle the logic
  // For example, let's add a list of selected categories

  // A list of categories
  final List<String> categories = [
    'Smartphone',
    'Laptop',
    'Computer',
    'Television',
    'Camera',
    'Radio',
    'Tablet',
    'Sound System',
  ];

  // List to track selected categories
  var selectedCategories = <String>[].obs;

  // Method to toggle category selection
  void toggleCategorySelection(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  // A method to update the categories (perform some action)
  void updateCategories() {
    // You can define what should happen when the 'Update' button is pressed
    // For example, printing the selected categories or sending them to a server
    print('Selected categories: $selectedCategories');
  }
}
