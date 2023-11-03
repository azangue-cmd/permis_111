import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/constants/constant_permis.dart';
import 'package:permis_111/model/user_model.dart';

class UserDataCRUD {
  static addNewUser({
    required UserModel userModel,
    required BuildContext context,
  }) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.phoneNumber)
          .set(userModel.toMap())
          .whenComplete(() {
        log('Data Added');
        CommonFunction.showToast(
            context: context, message: 'User Added Successfull');
      });
    } catch (e) {
      log(e.toString());
      CommonFunction.showToast(
        context: context, message: e.toString());
    }
  }

  static Future checkUser()async{
    try{
      await firestore
        .collection('users')
        .where('mobileNum', isEqualTo: auth.currentUser!.phoneNumber)
        .get()
        .then((value) => value.size > 0 ? true : false);
    }catch(e){
      log(e.toString());
    }
    
      
      
      /*
      if(value.docs.isEmpty){
        log('User Not Found');
        return false;
      }else{
        log('User Found');
        return true;
      }
      */

   
  }
}
