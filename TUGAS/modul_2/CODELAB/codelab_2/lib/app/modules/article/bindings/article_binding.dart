import 'package:get/get.dart';

import '../controllers/article_controller.dart';

class ArticleDetailBinding extends  Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArticleDetailController());
  }
  
}