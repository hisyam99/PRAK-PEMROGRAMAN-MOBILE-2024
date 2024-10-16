import 'package:get/get.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profileView/bindings/profileView_binding.dart';
import '../modules/profileView/views/profileView_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;
  static const LOGIN = Routes.LOGIN;
  static const PROFILE = Routes.PROFILE;
  static const ProfileView = Routes.profileView;
  static const CATEGORY = Routes.CATEGORY;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(name: _Paths.HOME, page: () => const HomeView(), bindings: [
      HomeBinding(),
      NavbarBinding(),
      CategoryBinding(),
    ]),
    GetPage(name: _Paths.PROFILE, page: () => const ProfileViews(), bindings: [
      ProfileBinding(),
      NavbarBinding(),
    ]),
    GetPage(name: _Paths.ProfileView, page: () => const ProfileViewView(), bindings: [
      ProfileViewBinding(),
    ]),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CategoryView(), // Ensure this points to CategoryView
      binding: CategoryBinding(),
    ),
  ];
}
