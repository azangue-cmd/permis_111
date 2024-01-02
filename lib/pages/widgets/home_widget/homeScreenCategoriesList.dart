import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permis_111/constants/constant_permis.dart';
import 'package:permis_111/view/user/product_category_screen/product_category_screen.dart';


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
          itemCount: categorisPermis.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, PageTransition(child: 
                ProductCategoryScreen(productCategory: categorisPermis[index]), 
                type: PageTransitionType.rightToLeft,
                ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                    
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                       image: AssetImage('assets/images/permis_categories/${categorisPermis[index]}.jpg'),
                       height: height * 0.07,
                      ), 
                      Text(
                        categorisPermis[index],
                        style: textTheme.labelMedium,
                      ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}