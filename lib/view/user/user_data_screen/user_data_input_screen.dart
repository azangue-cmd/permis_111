import 'package:flutter/material.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/constants/constant_permis.dart';
import 'package:permis_111/controller/services/user_data_crud_services/user_data_CRUD_services.dart';

import '../../../model/user_model.dart';
import '../../../utils/colors.dart';

class UserDataInputScreen extends StatefulWidget {
  const UserDataInputScreen({super.key});

  @override
  State<UserDataInputScreen> createState() => _UserDataInputScreenState();
}

class _UserDataInputScreenState extends State<UserDataInputScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController parentCodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      phoneController.text = auth.currentUser!.phoneNumber ?? '';
    });
  }

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
        body: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.all(
              16
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  cursorWidth: width * 0.005,
                  decoration: InputDecoration(
                    labelText: "Votre nom",
                    hintText: "Nom",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    )
                  ),
                ),
        
                CommonFunction.blankSpace(height * 0.02, 0),

                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: parentCodeController,
                        cursorWidth: width * 0.005,
                        decoration: InputDecoration(
                          labelText: "* Code parainage",
                          hintText: "Code",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                          )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un code';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                CommonFunction.blankSpace(height * 0.02, 0),

                TextFormField(
                  controller: phoneController,
                  cursorWidth: width * 0.005,
                  decoration: InputDecoration(
                    labelText: "Numero telephone",
                    hintText: "Numero",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    )
                  ),
                  enabled: false,
                ),
                //const Spacer(),
                CommonFunction.blankSpace(height * 0.08, 0),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                       UserModel userModel = UserModel(
                        mobileNum: phoneController.text.trim(),
                        name: nameController.text.trim(),
                        parentCode: parentCodeController.text.trim(),
                        userType: 'user');
                    await UserDataCRUD.addNewUser(
                      userModel: userModel,
                      context: context,
                    );
                    }
                    // UserModel userModel = UserModel(
                    //     mobileNum: phoneController.text.trim(),
                    //     name: nameController.text.trim(),
                    //     parentCode: parentCodeController.text.trim(),
                    //     userType: 'user');
                    // await UserDataCRUD.addNewUser(
                    //   userModel: userModel,
                    //   context: context,
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: amber,
                    minimumSize: Size(width, height * 0.06),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Continuer',
                    style: textTheme.bodyMedium,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
