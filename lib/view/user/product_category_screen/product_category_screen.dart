// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/constants/constants.dart';
import 'package:permis_111/controller/provier/product_by_category_provider/product_by_category_provider.dart';
import 'package:permis_111/controller/provier/user_product_provider/users_product_provider.dart';
import 'package:permis_111/model/product_model.dart';
import 'package:permis_111/pages/widgets/product_display_widget_screen/search_product_appbar.dart';
import 'package:permis_111/utils/colors.dart';
import 'package:permis_111/view/user/product_screen/product_screen.dart';
import 'package:provider/provider.dart';

import '../../../controller/services/users_product_services/users_product_servives.dart';
import '../../../model/user_product_model.dart';

class ProductCategoryScreen extends StatefulWidget {
   ProductCategoryScreen({super.key, required this.productCategory});
  String productCategory;

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  getDay(int dayNum) {
    switch (dayNum % 7) {
      case 0:
        return 'Lundi';
      case 1:
        return 'Mardi';
      case 2:
        return 'Mercredi';
      case 3:
        return 'Jeudi';
      case 4:
        return 'Vendredi';
      case 5:
        return 'Samedi';
      case 6:
        return 'Dimanche';
      default:
        'Samedi';
    }
  }

  getMouth(int deliveryDate) {
    if (DateTime.now().month == 2) {
      if (deliveryDate > 28) {
        return 'Mars';
      } else {
        return 'Fevrier';
      }
    }
    if (DateTime.now().month == 4 ||
        DateTime.now().month == 6 ||
        DateTime.now().month == 8 ||
        DateTime.now().month == 10 ||
        DateTime.now().month == 12) {
      if ((deliveryDate > 30) && (DateTime.now().month == 12)) {
        return 'Janvier';
      }
      if (deliveryDate > 30) {
        int month = DateTime.now().month + 1;
        switch (month) {
          case 1:
            return 'Janvier';
          case 2:
            return 'Fevrier';
          case 3:
            return 'Mars';
          case 4:
            return 'Avril';
          case 5:
            return 'Mai';
          case 6:
            return 'Juin';
          case 7:
            return 'Juillet';
          case 8:
            return 'Aout';
          case 9:
            return 'Septembre';
          case 10:
            return 'Octobre';
          case 11:
            return 'Novembre';
          case 12:
            return 'Decembre';
        }
      } else {
        int month = DateTime.now().month;
        switch (month) {
          case 1:
            return 'Janvier';
          case 2:
            return 'Fevrier';
          case 3:
            return 'Mars';
          case 4:
            return 'Avril';
          case 5:
            return 'Mai';
          case 6:
            return 'Juin';
          case 7:
            return 'Juillet';
          case 8:
            return 'Aout';
          case 9:
            return 'Septembre';
          case 10:
            return 'Octobre';
          case 11:
            return 'Novembre';
          case 12:
            return 'Decembre';
        }
      }
    }
    log(DateTime.now().month);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsBasedOnCategoryProvider>()
          .fetchProducts(category: widget.productCategory);
    });
  } 

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(width * 1, height * 0.08),
            child: SearchProductAppBar(width: width, height: height),
          ),
          body: Consumer<ProductsBasedOnCategoryProvider>(
              builder: (context, usersProductProvider, child) {
            if (usersProductProvider.productsFetched == false) {
              return SizedBox();
            } else {
              if (usersProductProvider.products.isEmpty) {
                return const Center(
                  child: Text('Opps! Product not found'),
                );
              } else {
                return ListView.builder(
                  itemCount: usersProductProvider.products.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ProductModel currentProduct =
                        usersProductProvider.products[index];
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
                              productModel: currentProduct,
                            ),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.41,
                        width: width,
                        decoration: BoxDecoration(
                            border: Border.all(color: greyShade3),
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.03, vertical: height * 0.007),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: greyShade1,
                                child: Image.network(
                                  currentProduct.imagesURL![0],
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02,
                                  vertical: height * 0.03,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentProduct.name ?? '',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.bodySmall!.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    CommonFunction.blankSpace(
                                        height * 0.005, 0),
                                    Row(
                                      children: [
                                        Text(
                                          '0.0',
                                          style: textTheme.bodyMedium!
                                              .copyWith(color: teal),
                                        ),
                                        CommonFunction.blankSpace(
                                            0, width * 0.01),
                                        RatingBar(
                                          initialRating: 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: width * 0.07,
                                          ratingWidget: RatingWidget(
                                              full: Icon(
                                                Icons.star,
                                                color: amber,
                                              ),
                                              half: Icon(
                                                Icons.star_half,
                                                color: amber,
                                              ),
                                              empty: Icon(
                                                Icons.star_outline_sharp,
                                                color: amber,
                                              )),
                                          itemPadding: EdgeInsets.zero,
                                          onRatingUpdate: (rating) {},
                                        ),
                                        CommonFunction.blankSpace(
                                            0, width * 0.02),
                                        Text('(0)',
                                            style: textTheme.bodyMedium),
                                      ],
                                    ),
                                    CommonFunction.blankSpace(height * 0.01, 0),
                                    RichText(
                                      maxLines: 2,
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: currentProduct
                                                .discountedPrice!
                                                .toStringAsFixed(0),
                                            style: textTheme.bodyLarge!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        TextSpan(
                                            text: 'FRCS',
                                            style: textTheme.bodySmall!
                                                .copyWith(fontSize: 12)),
                                        TextSpan(
                                            text: '\tMRP:',
                                            style: textTheme.labelMedium!
                                                .copyWith(color: grey)),
                                        TextSpan(
                                            text:
                                                '${currentProduct.price!.toStringAsFixed(0)} frcs',
                                            style: textTheme.labelMedium!
                                                .copyWith(
                                                    color: grey,
                                                    decoration: TextDecoration
                                                        .lineThrough)),
                                        TextSpan(
                                            text:
                                                '\t(${currentProduct.discountPercentage!.toStringAsFixed(0)}% off)',
                                            style:
                                                textTheme.labelMedium!.copyWith(
                                              color: grey,
                                            )),
                                      ]),
                                    ),
                                    CommonFunction.blankSpace(height * 0.01, 0),
                                    Text(
                                      'Économisez avec EMI sans frais',
                                      style: textTheme.labelMedium!.copyWith(
                                        color: grey,
                                      ),
                                    ),
                                    CommonFunction.blankSpace(height * 0.01, 0),
                                    RichText(
                                      maxLines: 2,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Obtenez-le par ',
                                            style:
                                                textTheme.labelMedium!.copyWith(
                                              color: grey,
                                            ),
                                          ),
                                          TextSpan(
                                            text: getDay(
                                                DateTime.now().weekday + 6),
                                            style:
                                                textTheme.labelMedium!.copyWith(
                                              color: black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ', ${DateTime.now().day + 0} ',
                                            style:
                                                textTheme.labelMedium!.copyWith(
                                              color: black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                getMouth(DateTime.now().month),
                                            style:
                                                textTheme.labelMedium!.copyWith(
                                              color: black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      currentProduct.discountedPrice! > 500
                                          ? 'Livraison gratuite par Permis 111'
                                          : 'Frais de livraison appliqués',
                                      style: textTheme.labelMedium!.copyWith(
                                        color: grey,
                                      ),
                                    ),
                                    CommonFunction.blankSpace(height * 0.01, 0),
                                    ElevatedButton(
                                      onPressed: () async {
                                        UserProductModel model =
                                            UserProductModel(
                                          imagesURL: currentProduct.imagesURL,
                                          name: currentProduct.name,
                                          category: currentProduct.category,
                                          description:
                                              currentProduct.description,
                                           brandName: currentProduct.brandName,
                                          price: currentProduct.price,
                                          discountedPrice:
                                              currentProduct.discountedPrice,
                                          productID: currentProduct.productID,
                                          productSellerID:
                                              currentProduct.productSellerID,
                                          inStock: currentProduct.inStock,
                                          discountPercentage:
                                              currentProduct.discountPercentage,
                                          productCount: 1,
                                          time: DateTime.now(),
                                        );
                                        await UsersProductService
                                            .addProductToCart(
                                          context: context,
                                          productModel: model,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: amber,
                                        minimumSize:
                                            Size(width * 0.07, height * 0.05),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Text(
                                        'Ajouter au panier',
                                        style: textTheme.bodyMedium,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          })),
    );
  }
}
