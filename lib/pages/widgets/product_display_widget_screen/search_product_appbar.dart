import 'package:flutter/material.dart';
import 'package:permis_111/pages/widgets/product_display_widget_screen/search_product_display_screnn.dart';

import '../../../utils/colors.dart';

class SearchProductAppBar extends StatelessWidget {
  const SearchProductAppBar({super.key
  ,required this.width,
  required this.height});
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
      child: const SearchProductDisplayScreen(),
      //endregion search
    );

  }
}