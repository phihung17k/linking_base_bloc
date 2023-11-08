import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/item_category_model.dart';

class FileUtil {
  static Future<List<ItemCategoryModel>> loadCategoriesJson() async {
    return await rootBundle.loadStructuredData(
      'assets/text/item_category_v2.json',
      (jsonString) {
        List<ItemCategoryModel> categories = [];
        List<dynamic> dataList = jsonDecode(jsonString);
        for (Map<String, dynamic> data in dataList) {
          String topic = data['topic'];
          List<dynamic> elements = data['elements'];
          for (Map<String, dynamic> category in elements) {
            category['topic'] = topic;
            category['image'] = "assets/images/${category['image']}";
            categories.add(ItemCategoryModel.fromMap(category));
          }
        }
        return Future.value(categories);
      },
    );
  }
}