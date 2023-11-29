import 'package:flutter/material.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/controller/provier/address_provider.dart';
import 'package:permis_111/model/address_model.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';

class HomeScreenUserAdressBar extends StatelessWidget {
  const HomeScreenUserAdressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: height * 0.06,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: addressBarGradientColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child:
          Consumer<AddressProvider>(builder: (context, addresPovider, child) {
        if (addresPovider.fetchedCurrentSelectedAddress == true) {
          AddressModel selectedAddress = addresPovider.currentSelectedAddress;
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_pin,
                color: black,
              ),
              CommonFunction.blankSpace(0, width * 0.02),
              Text(
                'Deliver to ${selectedAddress.name} - ${selectedAddress.town}, ${selectedAddress.state}',
                style: textTheme.bodySmall,
                )
            ],
          );
        }
        else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_pin,
                color: black,
              ),
              CommonFunction.blankSpace(0, width * 0.02),
               Text(
                'Deliver to user - City - State',
                style: textTheme.bodySmall,
                )
            ],
          );
        } 
      }),
    );
  }
}
