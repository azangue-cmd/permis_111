import 'package:flutter/material.dart';
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
  TextEditingController mobileController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController towmController = TextEditingController();
  TextEditingController stateController = TextEditingController();

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
            horizontal: width * 0.03,
            vertical: height * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AddressScreenTextField(
                  textController: nameController,
                  title: "Enter your name",
                  hintText: "Enter your name",
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                AddressScreenTextField(
                  textController: mobileController,
                  title: "Enter your mobile number",
                  hintText: "Enter your mobile number",
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                AddressScreenTextField(
                  textController: houseController,
                  title: "Enter your House No / quartier.",
                  hintText: "Enter your House No / quartier.",
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                AddressScreenTextField(
                  textController: areaController,
                  title: "Enter your Area/voter region",
                  hintText: "Area/voter region",
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                AddressScreenTextField(
                  textController: landmarkController,
                  title: "Enter your LandMark",
                  hintText: "Landmark",
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                AddressScreenTextField(
                  textController: pincodeController,
                  title: "Enter your PINCODE",
                  hintText: "pincode",
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                AddressScreenTextField(
                  textController: towmController,
                  title: "Enter your Town",
                  hintText: "Towm",
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                AddressScreenTextField(
                  textController: stateController,
                  title: "Enter your Town",
                  hintText: "State",
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                
                CommonFunction.blankSpace(height * 0.04, 0),
                ElevatedButton(
                  onPressed: () {
                    Uuid uuid = const Uuid();
                    String docID = uuid.v1();
                    AddressModel addressModel = AddressModel(
                      name: nameController.text.trim(),
                      mobileNumber: mobileController.text.trim(),
                      authenticatedMobileNumber: auth.currentUser!.phoneNumber,
                      houseNumber: houseController.text.trim(),
                      area: areaController.text.trim(),
                      landMark: landmarkController.text.trim(),
                      pincode: pincodeController.text.trim(),
                      town: towmController.text.trim(),
                      state: stateController.text.trim(),
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

