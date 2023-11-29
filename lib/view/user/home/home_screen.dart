//traduire tout les textes en francais
// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/constants/constant_permis.dart';
import 'package:permis_111/controller/provier/address_provider.dart';
import 'package:permis_111/controller/services/user_data_crud_services/user_data_CRUD_services.dart';
import 'package:provider/provider.dart';
import '../../../pages/widgets/home_widget/homeScreenBanner.dart';
import '../../../pages/widgets/home_widget/homeScreenCategoriesList.dart';
import '../../../pages/widgets/home_widget/homePageAppBar.dart';
import '../../../pages/widgets/home_widget/homeScreenUserAdressBar.dart';
import '../../../pages/widgets/home_widget/todaysDealsHomeScreenWidget.dart';
import '../../../utils/colors.dart';
import '../address_screen/address_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController todaysDealsCarouselController = CarouselController();

  checkUserAddress() async {
    bool userAddressPresent = await UserDataCRUD.checkUsersAddress();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (userAddressPresent == false) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SafeArea(
              child: Container(
                height: height * 0.3,
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.04,
                  horizontal: width * 0.03,
                ),
                width: width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Address',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.15,
                      child: ListView.builder(
                          itemCount: 1,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (index == 0) {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: const AdressScreen(),
                                      type: PageTransitionType.rightToLeft,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: width * 0.35,
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03,
                                  vertical: height * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: greyShade3,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Builder(builder: (context) {
                                  if (index == 0) {
                                    return Text(
                                      'Add Address',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: greyShade3),
                                    );
                                  }
                                  return Text(
                                    'Add Address',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: greyShade3),
                                  );
                                }),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserAddress();
      context.read<AddressProvider>().getCurrentSelectedAddress();
    });
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
                  textBtnName: 'En savoir plus',
                  productPicNamesList: headphonesProductDeals,
                  offerFor: 'headphones'),
              CommonFunction.divider(),
              Container(
                  height: height * 0.35,
                  width: width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/carousel_permis_slideshow/permis7.jpg'),
                      fit: BoxFit.fill,
                    ),
                  )),
              CommonFunction.divider(),
              OtherOfferGridWidget(
                  title: '70% de réduction | nos meilleures offres',
                  textBtnName: 'Voir toutes les offres',
                  productPicNamesList: clothingProductDealsList,
                  offerFor: 'clothing'),
              CommonFunction.divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonFunction.blankSpace(height * 0.01, 0),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03, vertical: height * 0.01),
                    child: Text(
                      'plus de documentaire sur 111 TV',
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
                          'assets/images/carousel_permis_slideshow/permis8.jpg'),
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
                                'assets/images/permis_offersNsponcered/${productPicNamesList[index]}.jpeg'),
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
                      offerFor == 'headProductphones'
                          ? headphoneDeals(index)
                          : clothingDeals(index),
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
