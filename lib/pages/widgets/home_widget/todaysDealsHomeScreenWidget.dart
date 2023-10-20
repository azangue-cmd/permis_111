import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../constants/common_function.dart';
import '../../../constants/constants.dart';
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
    todaysDealsCarouselController:
    todaysDealsCarouselController;
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
            //CommonFunction.blankSpace(height * 0.01, 0),
            Text(
              '50%-80% off | Latest deals.',
              style: textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            CarouselSlider(
              carouselController: todaysDealsCarouselController,
              options: CarouselOptions(
                height: height * 0.23,
                autoPlay: true,
                viewportFraction: 1,
              ),
              items: todaysDeals.map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        //margin: EdgeInsets.symmetric(horizontal: 3.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/todays_deals/${i}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        //child: Text('text $i', style: TextStyle(fontSize: 16.0),)
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
                    'Upto 62% off',
                    style: textTheme.labelMedium!.copyWith(
                      color: white,
                    ),
                  ),
                ),
                CommonFunction.blankSpace(0, width * 0.02),
                Text(
                  'Deal of the Day',
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
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 20,
                ),
                shrinkWrap: true,
                itemBuilder: (context, index) {
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
                          image: AssetImage(
                              'assets/images/todays_deals/${todaysDeals[index]}'),
                          fit: BoxFit.cover,
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
            //CommonFunction.blankSpace(height * 0.01, 0),
            TextButton(
              onPressed: () {},
              child: Text(
                'See all Deals ',
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
