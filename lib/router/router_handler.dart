import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../pages/product/product_deatil_page.dart';

Handler detailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String productId = params['id'].first;
      print("路由的ID" + productId);
      return ProductDetail(productId);
    }

);
