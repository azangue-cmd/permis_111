import 'package:flutter/material.dart';

import '../../../constants/common_function.dart';
import '../../../utils/colors.dart';

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
        body:  Container(
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
                    title: "Enter your House No.",
                    hintText: "Enter your House No.",
                  ),
                  CommonFunction.blankSpace(height * 0.01, 0),
                  AddressScreenTextField(
                    textController: areaController,
                    title: "Enter your Area",
                    hintText: "Area",
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
                    textController: nameController,
                    title: "Enter your Town",
                    hintText: "Towm",
                  ),
                  CommonFunction.blankSpace(height * 0.01, 0),
                  AddressScreenTextField(
                    textController: nameController,
                    title: "Enter your Town",
                    hintText: "Towm",
                  ),
                  CommonFunction.blankSpace(height * 0.01, 0),
                  AddressScreenTextField(
                    textController: nameController,
                    title: "Enter your Stade",
                    hintText: "State",
                  ),
                  CommonFunction.blankSpace(height * 0.04, 0),

                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: amber, 
                      minimumSize: Size(
                        width, height * 0.06,
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

class AddressScreenTextField extends StatelessWidget {
  const AddressScreenTextField({
    super.key,
    required this.textController,
    required this.title,
    required this.hintText
  });

  final TextEditingController textController;
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.bodyMedium,
        ),
        CommonFunction.blankSpace(height * 0.0005, 0),
        TextField(
          controller: textController,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: width * 0.03),
            hintText: hintText,
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
      ],
    );
  }
}
