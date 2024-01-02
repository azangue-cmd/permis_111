import 'package:flutter/material.dart';
import 'package:permis_111/controller/services/users_product_services/users_product_servives.dart';
import 'package:permis_111/model/product_model.dart';

class ProductsBasedOnCategoryProvider extends ChangeNotifier {
  List<ProductModel> products = [];
  bool productsFetched = false;

  fetchProducts({required String category}) async {
    products = [];
    products = await UsersProductService.fetchProductBasedOnCategory(
        category: category);
        productsFetched = true;
        notifyListeners();
  }
}
