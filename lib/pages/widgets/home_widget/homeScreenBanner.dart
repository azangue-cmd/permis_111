import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:permis_111/constants/constant_permis.dart';


class HomeScreenBanner extends StatelessWidget {
  const HomeScreenBanner({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height * 0.3,
        autoPlay: true,
        viewportFraction: 1,
        ),
      items: carouselPicturesPermis.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              //margin: EdgeInsets.symmetric(horizontal: 3.0),
              decoration: BoxDecoration(
                //color: Colors.amber,
                image: DecorationImage(image: AssetImage('assets/images/carousel_permis_slideshow/$i.jpg'),
                fit: BoxFit.fill,
                ),
              ),
              //child: Text('text $i', style: TextStyle(fontSize: 16.0),)
            );
          },
        );
      }).toList(),
    );
  }
}