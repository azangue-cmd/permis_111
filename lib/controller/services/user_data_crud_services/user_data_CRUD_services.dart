import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/constants/constant_permis.dart';
import 'package:permis_111/controller/services/auth_services/signInLogic.dart';
import 'package:permis_111/model/address_model.dart';
import 'package:permis_111/model/user_model.dart';

class UserDataCRUD {
  static addNewUser({
    required UserModel userModel,
    required BuildContext context,
  }) async {
    try {
      var user = await firestore
          .collection('users')
          .doc(auth.currentUser!.phoneNumber)
          .set(userModel.toMap())
          .whenComplete(() {
        log('Data Added');
        CommonFunction.showToast(
            context: context, message: 'User Added Successfull');
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              child: const SignInLogic(),
              type: PageTransitionType.rightToLeft,
            ),
            (route) => false);
      });
    } catch (e) {
      log(e.toString());
      CommonFunction.showToast(context: context, message: e.toString());
    }
  }

  static Future<bool> checkUser() async {
    bool userPresent = false;
    try {
      await firestore
          .collection('users')
          .where('mobileNum', isEqualTo: auth.currentUser!.phoneNumber)
          .get()
          .then((value) =>
              value.size > 0 ? userPresent = true : userPresent = false);
    } catch (e) {
      log(e.toString());
    }
    log(userPresent.toString());
    return userPresent;
  }

  static Future<bool> userIsSeller() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('users')
          .doc(auth.currentUser!.phoneNumber)
          .get();
      if (snapshot.exists) {
        UserModel userModel = UserModel.fromMap(snapshot.data()!);
        print("----------------------------------------------");
        print('User Type is: ${userModel.userType}');
        if (userModel.userType != 'user') {
          return true;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  static Future addUserAddress({
    required BuildContext context,
    required AddressModel addressModel,
    required String docID,
  }) async {
    try {
      await firestore
          .collection('Adresse')
          .doc(auth.currentUser!.phoneNumber)
          .collection('address')
          .doc(docID)
          .set(addressModel.toMap())
          .whenComplete(() {
        log('Data Added');
        CommonFunction.showToast(
            context: context, message: 'Address Added Successfull');
        Navigator.pop(context);
      });
    } catch (e) {
      log(e.toString());
      CommonFunction.showToast(context: context, message: e.toString());
    }
  }

  static Future<bool> checkUsersAddress() async {
    bool addressPresent = false;
    try {
      await firestore
          .collection('Adresse')
          .doc(auth.currentUser!.phoneNumber)
          .collection('address')
          .get()
          .then((value) =>
              value.size > 0 ? addressPresent = true : addressPresent = false);
    } catch (e) {
      log(e.toString());
    }
    log(addressPresent.toString());
    return addressPresent;
  }

  static Future<List<AddressModel>> getAllAddress() async {
    List<AddressModel> allAddress = [];
    AddressModel defaultAddress = AddressModel();
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('Adresse')
          .doc(auth.currentUser!.phoneNumber)
          .collection('address')
          .get();

      for (var element in snapshot.docs) {
        allAddress.add(AddressModel.fromMap(element.data()));
        AddressModel currentAddress = AddressModel.fromMap(element.data());
        if (currentAddress.isDefault == true) {
          defaultAddress = currentAddress;
        }
      }

      // snapshot.docs.forEach((element) {
      //   allAddress.add(AddressModel.fromMap(element.data()));
      //   AddressModel currentAddress = AddressModel.fromMap(element.data());
      //   if (currentAddress.isDefault == true) {
      //     defaultAddress = currentAddress;
      //   }
      // });
    } catch (e) {
      log('errot found');
      log(e.toString());
    }
    for (var data in allAddress) {
      log(data.toMap().toString());
    }
    return allAddress;
  }

  static Future getCurrentSelectedAddress() async {
    AddressModel defaultAddress = AddressModel();
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('Adresse')
          .doc(auth.currentUser!.phoneNumber)
          .collection('address')
          .get();

      for (var element in snapshot.docs) {
        AddressModel currentAddress = AddressModel.fromMap(element.data());
        if (currentAddress.isDefault == true) {
          defaultAddress = currentAddress;
        }
      }

      // snapshot.docs.forEach((element) {
      //   AddressModel currentAddress = AddressModel.fromMap(element.data());
      //   if (currentAddress.isDefault == true) {
      //     defaultAddress = currentAddress;
      //   }
      // });
    } catch (e) {
      log('errot found');
      log(e.toString());
    }
    return defaultAddress;
  }
}
