import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:permis_111/controller/services/user_data_crud_services/user_data_CRUD_services.dart';
import 'package:permis_111/model/address_model.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/common_function.dart';
import '../../../constants/constant_permis.dart';
import '../../../utils/colors.dart';
import 'widget/address_screen_textField.dart';

class AdressScreen extends StatefulWidget {
  const AdressScreen({super.key});

  @override
  State<AdressScreen> createState() => _AdressScreenState();
}

class _AdressScreenState extends State<AdressScreen> {
  TextEditingController nameController = TextEditingController();
  String mobileController = " ";
  TextEditingController landController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController quaterController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(width, height * 0.10),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.03, vertical: height * 0.02),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: appBarGradientColor,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: const AssetImage(
                    'assets/images/permis111_5.png',
                  ),
                  height: height * 0.02,
                ),
              ],
            ),
          ),
        ),
        body: Container(
          width: width,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.04,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  cursorWidth: width * 0.005,
                  decoration:  InputDecoration(
                    labelText: "Votre nom",
                    hintText: "Votre nom",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    )
                  ),
                  
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                IntlPhoneField(
                  cursorWidth: width * 0.005,
                  initialCountryCode: "CM",
                    onChanged: (value) {
                      print(value.completeNumber);
                      mobileController = value.completeNumber;
                    },
                  decoration: InputDecoration(
                    labelText: "Numero de telephone",
                    hintText: "Numero de telephone",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    )
                  ),
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                TextFormField(
                  controller: landController,
                  cursorWidth: width * 0.005,
                  decoration: InputDecoration(
                    labelText: "Votre pays",
                    hintText: "pays",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    )
                  ),
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                TextFormField(
                  controller: townController,
                  cursorWidth: width * 0.005,
                  decoration: InputDecoration(
                    labelText: "Ville",
                    hintText: "Ville",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    )
                  ),
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                TextFormField(
                  controller: quaterController,
                  cursorWidth: width * 0.005,
                  decoration: InputDecoration(
                    labelText: "Quatier",
                    hintText: "Quatier",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    )
                  ),
                ),
                CommonFunction.blankSpace(height * 0.08, 0),
                ElevatedButton(
                  onPressed: () {
                    Uuid uuid = const Uuid();
                    String docID = uuid.v1();
                    AddressModel addressModel = AddressModel(
                      name: nameController.text.trim(),
                      mobileNumber: mobileController.trim(),
                      authenticatedMobileNumber: auth.currentUser!.phoneNumber,
                      houseNumber: landController.text.trim(),
                      area: townController.text.trim(),
                      landMark: quaterController.text.trim(),
                      docID: docID,
                      isDefault: true,
                    );
                    UserDataCRUD.addUserAddress(
                        context: context, 
                        addressModel: addressModel,
                        docID: docID,
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: amber,
                    minimumSize: Size(
                      width,
                      height * 0.06,
                    ),
                  ),
                  child: Text(
                    'Add Adress',
                    style: textTheme.bodyMedium,
                  ),
                ),
                CommonFunction.blankSpace(height * 0.02, 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

