import 'package:flutter/material.dart';
import 'package:permis_111/controller/services/user_data_crud_services/user_data_CRUD_services.dart';
import 'package:permis_111/model/address_model.dart';

class AddressProvider extends ChangeNotifier {
  List<AddressModel> allAdressModel = [];
  AddressModel currentSelectedAddress = AddressModel();
  bool fetchedCurrentSelectedAddress = false;
  bool fetchedAllAddress = false;

  getAllddress() async {
    allAdressModel = await UserDataCRUD.getAllAddress();
    fetchedAllAddress = true;
    notifyListeners();
  }

  getCurrentSelectedAddress() async {
    currentSelectedAddress = await UserDataCRUD.getCurrentSelectedAddress();
    fetchedCurrentSelectedAddress = true;
    notifyListeners();
  }
}
