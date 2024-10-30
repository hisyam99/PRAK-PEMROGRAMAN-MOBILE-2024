import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/models/article.dart';
import '../controllers/article_controller.dart';

// ignore: must_be_immutable
class ArticleDetailWebView extends GetView<ArticleDetailController> {
  final Article article;
  const ArticleDetailWebView({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Page"),
      ),
      body: article.url != null
          ? WebViewWidget(
              controller: controller.webViewController(article.url),
            )
          : const Center(child: Text('Invalid URL')),
    );
  }
}
