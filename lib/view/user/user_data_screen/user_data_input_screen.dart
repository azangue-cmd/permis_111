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
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.02,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your name',
                style: textTheme.bodyMedium,
              ),
              CommonFunction.blankSpace(height * 0.01, 0),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  hintStyle: textTheme.bodyMedium!.copyWith(
                    color: grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: secondaryColor,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: grey,
                    ),
                  ),
                ),
              ),
              CommonFunction.blankSpace(height * 0.02, 0),
              Text(
                'Phone Number',
                style: textTheme.bodyMedium,
              ),
              CommonFunction.blankSpace(height * 0.01, 0),
              TextField(
                controller: phoneController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Enter your phone number',
                  hintStyle: textTheme.bodyMedium!.copyWith(
                    color: grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: secondaryColor,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: grey,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  UserModel userModel = UserModel(
                      mobileNum: phoneController.text.trim(),
                      name: nameController.text.trim(),
                      userType: 'user');
                  await UserDataCRUD.addNewUser(
                    userModel: userModel,
                    context: context,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: amber,
                  minimumSize: Size(width, height * 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Proceed',
                  style: textTheme.bodyMedium,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
