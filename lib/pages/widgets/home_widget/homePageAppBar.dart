import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permis_111/pages/widgets/home_widget/searchWidgetScreen.dart';

import '../../../controller/services/product_services/product_services.dart';
import '../../../utils/colors.dart';
import '../../../view/searched_product_screen/searched_product_screen.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      //margin: EdgeInsets,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, 
          vertical: height * 0.01),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: appBarGradientColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      //region Search screen
      child: SearchWidget(width: width),
      //endregion search
    );
  }
}