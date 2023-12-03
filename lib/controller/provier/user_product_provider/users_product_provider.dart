import 'package:flutter/material.dart';
import 'package:permis_111/model/product_model.dart';

import '../../services/users_product_services/users_product_servives.dart';


class UsersProductProvider extends ChangeNotifier {
  List<ProductModel> searchedProducts = [];

  bool productsFetched = false;

  emptySearchedProductsList() {
    searchedProducts = [];
    productsFetched = false;
    notifyListeners();
  }

  getSearchedProducts({required String productName}) async {
    searchedProducts = await UsersProductService.getProducts(productName);
    productsFetched = true;
    notifyListeners();
  }
}
