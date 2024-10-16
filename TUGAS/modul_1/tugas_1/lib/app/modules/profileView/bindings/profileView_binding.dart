// File 3: /lib/app/modules/profile/bindings/profile_binding.dart
import 'package:get/get.dart';
import '../controllers/profileView_controller.dart';

class ProfileViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileViewController>(() => ProfileViewController());
  }
}