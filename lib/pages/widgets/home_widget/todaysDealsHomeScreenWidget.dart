import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permis_111/constants/constant_permis.dart';
import 'package:permis_111/controller/provier/deal_of_the_day_provider/deal_of_the_provider.dart';
import 'package:permis_111/model/product_model.dart';
import 'package:permis_111/view/user/product_screen/product_screen.dart';
import 'package:provider/provider.dart';

import '../../../constants/common_function.dart';
//import '../../../constants/constants.dart';
import '../../../controller/services/users_product_services/users_product_servives.dart';
import '../../../utils/colors.dart';

class TodaysDealsHomeScreenWidget extends StatelessWidget {
  const TodaysDealsHomeScreenWidget({
    super.key,
    required this.todaysDealsCarouselController,
  });

  final CarouselController todaysDealsCarouselController;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: width,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CommonFunction.blankSpace(height * 0.01, 0),
            Text(
              '50%-80% de réduction | Dernières offres.',
              style: textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15
              ),
            ),
            CommonFunction.blankSpace(height * 0.01, 0),

            Consumer<DealOfTheDayProvider>(
                builder: (context, dealOfTheDayProvider, child) {
              if (dealOfTheDayProvider.dealsFetched == false) {
                return Container(
                    height: height * 0.2,
                    width: width,
                    alignment: Alignment.center,
                    child: Text(
                      'Chargement des dernières offres',
                      style: textTheme.bodySmall,
                      
                    ));
              } else {
                return Column(
                  children: [
                    CarouselSlider(
                      carouselController: todaysDealsCarouselController,
                      options: CarouselOptions(
                        height: height * 0.23,
                        autoPlay: true,
                        viewportFraction: 1,
                      ),
                      items: dealOfTheDayProvider.deals.map(
                        (i) {
                          ProductModel currentProduct = i;
                          return Builder(
                            builder: (BuildContext context) {
                              return InkWell(
                                onTap: () async {
                                  await UsersProductService.addRecentlySeenProduct(
                                    context: context,
                                    productModel: currentProduct,
                                  );
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: ProductScreen(
                                          productModel: currentProduct),
                                      type: PageTransitionType.rightToLeft,
                                    ),
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  //margin: EdgeInsets.symmetric(horizontal: 3.0),
                                  decoration: BoxDecoration(
                                   // color: Colors.amber,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          currentProduct.imagesURL![0]),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  //child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                                ),
                              );
                            },
                          );
                        },
                      ).toList(),
                    ),
                    CommonFunction.blankSpace(height * 0.01, 0),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Jusqu’à 62% de réduction',
                    style: textTheme.labelMedium!.copyWith(
                      color: white,
                    ),
                  ),
                ),
                CommonFunction.blankSpace(0, width * 0.02),
                Text(
                  'Offre du jour',
                  style: textTheme.labelMedium!
                      .copyWith(color: red, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            CommonFunction.blankSpace(
              height * 0.01,
              0,
            ),
            GridView.builder(
                itemCount: dealOfTheDayProvider.deals.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 20,
                ),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ProductModel currentModel =
                      dealOfTheDayProvider.deals[index];
                  return InkWell(
                    onTap: () {
                      log(index.toString());
                      todaysDealsCarouselController.animateToPage(
                        index,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration( 
                        image: DecorationImage(
                          image: NetworkImage(
                              currentModel.imagesURL![0]),
                          fit: BoxFit.contain,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                  ],
                );
              }
            }),
            
            TextButton(
              onPressed: () {},
              child: Text(
                'Voir toutes les offres ',
                style: textTheme.bodySmall!.copyWith(
                  color: blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
