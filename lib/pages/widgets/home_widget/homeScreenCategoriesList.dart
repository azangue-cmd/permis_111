import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class HomeScreenCategoriesList extends StatelessWidget {
  const HomeScreenCategoriesList({
    super.key,
  
  });



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: height * 0.1,
      width: width ,
      child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                     image: AssetImage('assets/images/categories/${categories[index]}.png'),
                     height: height * 0.07,
                    ), 
                    Text(
                      categories[index],
                      style: textTheme.labelMedium,
                    ),
                ],
              ),
            );
          }),
    );
  }
}