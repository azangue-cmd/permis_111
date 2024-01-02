import 'package:flutter/material.dart';
import 'package:permis_111/controller/services/users_product_services/users_product_servives.dart';
import 'package:permis_111/model/product_model.dart';

class DealOfTheDayProvider extends ChangeNotifier {
  List<ProductModel> deals = [];
  bool dealsFetched = false;

  fetchTodayDeals() async {
    deals = [];
    deals = await UsersProductService.featchDealOfTheDay();
    dealsFetched = true;
    notifyListeners();
  }

  
}
