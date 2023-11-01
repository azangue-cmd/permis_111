import 'package:flutter/material.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/utils/colors.dart';

import '../../../pages/widgets/home_widget/homePageAppBar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(width * 1, height * 0.08),
          child: HomePageAppBar(width: width, height: height),
        ),
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: 'Subtotal ', style: textTheme.bodyLarge),
                      TextSpan(
                        text: '₹ 52300',
                        style: textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                SizedBox(
                  height: height * 0.06,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: teal,
                      ),
                      CommonFunction.blankSpace(0, width * 0.01),
                      Expanded(
                        child: Column(
                          children: [
                            RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text:
                                        'Your order is eligible for free delivery. ',
                                    style: textTheme.bodyMedium!
                                        .copyWith(color: teal, fontSize: 13),
                                  ),
                                  TextSpan(
                                      text: ' Select this option at checkout.',
                                      style: textTheme.bodyMedium!
                                          .copyWith(fontSize: 14)),
                                ])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: amber,
                      minimumSize: Size(width, height * 0.06),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Proceed to Buy', style: textTheme.bodyMedium)),
                CommonFunction.blankSpace(height * 0.01, 0),
                CommonFunction.divider(),
                CommonFunction.blankSpace(height * 0.01, 0),
                ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        //height: height * 0.3,
                        width: width,
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02, 
                          vertical: height * 0.01,
                          ),
                        margin: EdgeInsets.symmetric(
                          vertical: height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), 
                            color: greyShade2,
                        ),
                        child:  Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Image(
                                    image:  AssetImage(
                                      'assets/images/permis_categories/love.jpg',
                                      ),
                                      fit: BoxFit.fitWidth,
                                    ),
                                    CommonFunction.blankSpace(height * 0.02, 0),
                                    Container(
                                      height: height * 0.07,
                                      width: width * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: greyShade3,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                               decoration: BoxDecoration(    
                                                       border: Border(
                                                          right: BorderSide(
                                                            color: greyShade3,
                                                          ),
                                                       ),
                                               ),
                                              child:  Icon(
                                                Icons.remove,
                                                color: black,
                                              ),
                                            )
                                            ),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              color: white,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '1',
                                                textAlign: TextAlign.center,
                                                style: textTheme.bodyMedium,
                                              ),
                                            ),
                                            ),
                                          Expanded(
                                            flex: 2,
                                            child:  Container(
                                              decoration: BoxDecoration(    
                                                       border: Border(
                                                          left: BorderSide(
                                                            color: greyShade3,
                                                          ),
                                                       ),
                                               ),
                                              child:   Icon(
                                                Icons.add,
                                                color: black,
                                              ),
                                            )
                                            )
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              ),
                              CommonFunction.blankSpace(0, width * 0.02,),
                              Expanded(
                                flex: 17,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Product name',
                                      style: textTheme.bodyLarge,
                                    ),
                                    CommonFunction.blankSpace(height * 0.01, 0),
                                    Text(
                                      '₹ 21300',
                                      style: textTheme.displayMedium!.copyWith(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    CommonFunction.blankSpace(height * 0.01, 0),
                                    Text(
                                      'Eligible for free Shipping',
                                      style: textTheme.bodySmall!.copyWith(
                                        color: grey
                                      ),
                                    ),
                                    CommonFunction.blankSpace(height * 0.01, 0),
                                    Text(
                                      'In Stock',
                                      style: textTheme.bodySmall!.copyWith(
                                        color: teal
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: (){}, 
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: white,
                                            side: BorderSide(
                                              color: greyShade3
                                            ),

                                          ),
                                          child: Text(
                                            'Delete',
                                            style: textTheme.bodySmall,
                                          ),
                                          ),
                                          CommonFunction.blankSpace(0, width * 0.01,),
                                           // set the width to a specific value
                                            ElevatedButton(
                                              onPressed: (){}, 
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: white,
                                                side: BorderSide(
                                                  color: greyShade3,
                                                ),
                                              ),
                                              child: Text(
                                                'Save later',
                                                style: textTheme.bodySmall,
                                              ),
                                            
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                ),
                                
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
