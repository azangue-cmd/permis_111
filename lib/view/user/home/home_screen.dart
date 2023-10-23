import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:permis_111/constants/common_function.dart';
import '../../../constants/constants.dart';
import '../../../pages/widgets/home_widget/homeScreenBanner.dart';
import '../../../pages/widgets/home_widget/homeScreenCategoriesList.dart';
import '../../../pages/widgets/home_widget/homePageAppBar.dart';
import '../../../pages/widgets/home_widget/homeScreenUserAdressBar.dart';
import '../../../pages/widgets/home_widget/todaysDealsHomeScreenWidget.dart';
import '../../../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController todaysDealsCarouselController = CarouselController();
  headphoneDeals(int index) {
    switch (index) {
        
          case 0:
            return 'Bose';
          case 1:
            return 'BoAt';
          case 2:
            return 'Sony';
          case 3:
            return 'OnePlus';
        
    }
  }

  clothingDeals(int index) {
    
        switch (index) {
          case 0:
            return 'Kurtas, sarees & more';
          case 1:
            return 'Tops, dress & more';
          case 2:
            return 'T-Shirt, jeans & more';
          case 3:
            return 'View all';
        }
    }
  

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
//region appBar
        appBar: PreferredSize(
          preferredSize: Size(width * 1, height * 0.08),
          child: HomePageAppBar(width: width, height: height),
        ),
//endregion appBar
        body: SingleChildScrollView(
          child: Column(
            children: [
              const HomeScreenUserAdressBar(),
              CommonFunction.divider(),
              const HomeScreenCategoriesList(),
              CommonFunction.blankSpace(height * 0.01, 0),
              CommonFunction.divider(),
              HomeScreenBanner(height: height),
              TodaysDealsHomeScreenWidget(
                todaysDealsCarouselController: todaysDealsCarouselController,
              ),
              CommonFunction.divider(),
              OtherOfferGridWidget(
                  title: 'Latest Launces in Headphones',
                  textBtnName: 'Explore More ',
                  productPicNamesList: headphonesDeals,
                  offerFor: 'headphones'
                  ),
              CommonFunction.divider(),
              Container(
                    height: height * 0.35, 
                    width: width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/offersNsponcered/insurance.png'),
                        fit: BoxFit.fill, 
                      ),
                      )
                    ),
              CommonFunction.divider(),
              OtherOfferGridWidget(
                  title: 'minimum 70% off | Top offers on Clothing',
                  textBtnName: 'See all deals ',
                  productPicNamesList: clothingDealsList,
                  offerFor: 'clothing'
                  ),
              CommonFunction.divider(),    
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonFunction.blankSpace( height * 0.01, 0),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
                    child: Text(
                        'Watch Sixer only on miniTv',
                        style: textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ),
                  Container(
                    //height: height * 0.4,
                    width: width,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03,
                      vertical: height * 0.01,
                    ),
                    child: const Image(
                      image: AssetImage(
                      'assets/images/offersNsponcered/sixer.png'
                      ), 
                      fit: BoxFit.fill,
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),  
    );
  }

  Container OtherOfferGridWidget({
    required String title,
    required String textBtnName,
    required List<String> productPicNamesList,
    required String offerFor,
  }) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: height * 0.01),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          CommonFunction.blankSpace(height * 0.01, 0),
          GridView.builder(
            itemCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/offersNsponcered/${productPicNamesList[index]}'),
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
                    ),
                    Text(
                      offerFor == 'headphones' ? headphoneDeals(index) : clothingDeals(index),
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            },
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              textBtnName,
              style: textTheme.bodySmall!.copyWith(
                color: blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
