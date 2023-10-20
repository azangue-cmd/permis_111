import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:permis_111/constants/common_function.dart';
import '../../../pages/widgets/home_widget/homeScreenBanner.dart';
import '../../../pages/widgets/home_widget/homeScreenCategoriesList.dart';
import '../../../pages/widgets/home_widget/homePageAppBar.dart';
import '../../../pages/widgets/home_widget/homeScreenUserAdressBar.dart';
import '../../../pages/widgets/home_widget/todaysDealsHomeScreenWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController todaysDealsCarouselController = CarouselController();
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
              const HomeScreenCategoriesList(
                  ),
              CommonFunction.blankSpace(height * 0.01, 0),
              CommonFunction.divider(),
              HomeScreenBanner(height: height),
              TodaysDealsHomeScreenWidget(todaysDealsCarouselController: todaysDealsCarouselController,
                ),
              CommonFunction.divider(),
              SizedBox(
                width: width,
                child: Column(
                   
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


