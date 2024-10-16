import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;

  get tabController => null;

  void increment() => count.value++;

  buildScreens() {}

  var services = <Map<String, dynamic>>[
    {
      'title': 'Mobile Device Repair',
      'price': '\$15.00',
      'provider': 'Jenny Wilson',
      'image': 'assets/device_repair1.png', // Replace with actual image path
    },
    {
      'title': 'Laptop Repair',
      'price': '\$15.00',
      'provider': 'Bob',
      'image': 'assets/laptop_repair1.png',
    },
    {
      'title': 'Smartphone Repair',
      'price': '\$15.00',
      'provider': 'Bob',
      'image': 'assets/smartphone_repair1.png',
    },
    {
      'title': 'Camera Repair',
      'price': '\$15.00',
      'provider': 'Alan',
      'image': 'assets/camera_repair1.png',
    },
  ].obs;
}
