// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/constants/constant_permis.dart';
import 'package:permis_111/controller/services/product_services/product_services.dart';
import 'package:permis_111/controller/services/users_product_services/users_product_servives.dart';
import 'package:permis_111/model/user_product_model.dart';
import 'package:permis_111/utils/colors.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../pages/widgets/home_widget/homePageAppBar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePayementSuccess);
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePayementError);
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
  }

  @override
  dispose() {
    super.dispose();
    razorpay.clear();
  }

  void _handlePayementSuccess(PaymentSuccessResponse response) async {
    List<UserProductModel> cartItems = await UsersProductService.fetchCart();
    DateTime currentTime = DateTime.now();
    for (var product in cartItems) {
      UserProductModel model = UserProductModel(
        imagesURL: product.imagesURL,
        name: product.name,
        category: product.category,
        description: product.description,
        brandName: product.brandName,
        manufacturerName: product.manufacturerName,
        countryOfOrigin: product.countryOfOrigin,
        specifications: product.specifications,
        price: product.price,
        discountedPrice: product.discountedPrice,
        productID: product.productID,
        productSellerID: product.productSellerID,
        inStock: product.inStock,
        discountPercentage: product.discountPercentage,
        productCount: product.productCount,
        time: currentTime,
      );
      await ProductServices.addSalesData(
          context: context,
          productModel: model,
          userID: auth.currentUser!.phoneNumber!);
      await UsersProductService.addOrder(
        context: context,
        productModel: model,
      );
    }
  }

  void _handlePayementError(PaymentFailureResponse response) {
    CommonFunction.showErrorToast(
      context: context,
      message: 'Opps!! Product Purchase Failed',
    );
  }

  executPayement() {
    var options = {
      'key': keyID,
      // 'amount': widget.productModel.discountedPrice! * 100,
      'amount': 1 * 100,
      // here amount * 100 because razorpay counts amount in paise
      // i.e 100 paise = 1 Rupee
      // 'image': '<your Buisness email>',
      'name': 'Multiple Product',
      'description': 'Multiple Product ',
      'prefill': {
        'contact': auth.currentUser!.phoneNumber, // <USERS CONTACT NO>
        'email': 'permis111@gmail.com', // <USERS EMAIL NO.>
        //'email': auth.currentUser!.email, // <USERS EMAIL NO.>
      },
    };

    razorpay.open(options);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

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
          child: Stack(
            children: [
              StreamBuilder(
                  stream: UsersProductService.fetchCartProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No Product Addet to Cart',
                          style: textTheme.bodyMedium,
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      List<UserProductModel> cartProducts = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Subtotal ',
                                    style: textTheme.bodyLarge),
                                TextSpan(
                                  text:
                                      '${cartProducts.fold(0.0, (previousValue, produc) => previousValue + (produc.discountedPrice! * produc.productCount!)).toStringAsFixed(0)} frcs',
                                  style: textTheme.displaySmall!.copyWith(
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
                                                  .copyWith(
                                                      color: teal,
                                                      fontSize: 13),
                                            ),
                                            TextSpan(
                                                text:
                                                    ' Select this option at checkout.',
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
                              onPressed: executPayement,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: amber,
                                minimumSize: Size(width, height * 0.06),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text('Proceed to Buy',
                                  style: textTheme.bodyMedium)),
                          CommonFunction.blankSpace(height * 0.01, 0),
                          CommonFunction.divider(),
                          CommonFunction.blankSpace(height * 0.01, 0),
                          SizedBox(
                            height: height * 0.57,
                            child: ListView.builder(
                                itemCount: cartProducts.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  UserProductModel currentProduct =
                                      cartProducts[index];
                                  return Container(
                                    height: height * 0.3,
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
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image(
                                                image: NetworkImage(
                                                  currentProduct.imagesURL![0],
                                                ),
                                                fit: BoxFit.contain,
                                              ),
                                              CommonFunction.blankSpace(
                                                  height * 0.02, 0),
                                              Container(
                                                height: height * 0.07,
                                                width: width * 0.4,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: greyShade3,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: InkWell(
                                                          onTap: () async {
                                                            if (currentProduct
                                                                    .productCount ==
                                                                1) {
                                                              await UsersProductService
                                                                  .removeProductfromCart(
                                                                productId:
                                                                    currentProduct
                                                                        .productID!,
                                                                context:
                                                                    context,
                                                              );
                                                            }
                                                            await UsersProductService
                                                                .updateCountCartProduct(
                                                              productId:
                                                                  currentProduct
                                                                      .productID!,
                                                              newCount:
                                                                  currentProduct
                                                                          .productCount! -
                                                                      1,
                                                              context: context,
                                                            );
                                                          },
                                                          child: Container(
                                                            height:
                                                                double.infinity,
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border(
                                                                right:
                                                                    BorderSide(
                                                                  color:
                                                                      greyShade3,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Icon(
                                                              Icons.remove,
                                                              color: black,
                                                            ),
                                                          ),
                                                        )),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        color: white,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          currentProduct
                                                              .productCount
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: textTheme
                                                              .bodyMedium,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 2,
                                                        child: InkWell(
                                                          onTap: () async {
                                                            await UsersProductService
                                                                .updateCountCartProduct(
                                                              productId:
                                                                  currentProduct
                                                                      .productID!,
                                                              newCount:
                                                                  currentProduct
                                                                          .productCount! +
                                                                      1,
                                                              context: context,
                                                            );
                                                          },
                                                          child: Container(
                                                            height:
                                                                double.infinity,
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              //color: amber,
                                                              border: Border(
                                                                left:
                                                                    BorderSide(
                                                                  color:
                                                                      greyShade3,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Icon(
                                                              Icons.add,
                                                              color: black,
                                                            ),
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CommonFunction.blankSpace(
                                          0,
                                          width * 0.02,
                                        ),
                                        Expanded(
                                          flex: 17,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                currentProduct.name!,
                                                maxLines: 3,
                                                style: textTheme.bodyLarge,
                                              ),
                                              CommonFunction.blankSpace(
                                                  height * 0.01, 0),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${currentProduct.discountedPrice!.toStringAsFixed(0)} frcs',
                                                    style: textTheme
                                                        .displayMedium!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                    '\tMRP: ',
                                                    style: textTheme.bodySmall!
                                                        .copyWith(
                                                      color: grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${currentProduct.price!.toStringAsFixed(0)} frcs',
                                                    style: textTheme.bodySmall!
                                                        .copyWith(
                                                            color: grey,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                  ),
                                                ],
                                              ),
                                              CommonFunction.blankSpace(
                                                  height * 0.01, 0),
                                              Text(
                                                currentProduct
                                                            .discountedPrice! >
                                                        499
                                                    ? 'Eligible for free Shipping'
                                                    : 'Extra Delivery Charges Applied',
                                                style: textTheme.bodySmall!
                                                    .copyWith(color: grey),
                                              ),
                                              CommonFunction.blankSpace(
                                                  height * 0.01, 0),
                                              Text(
                                                'In Stock',
                                                style: textTheme.bodySmall!
                                                    .copyWith(color: teal),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      await UsersProductService
                                                          .removeProductfromCart(
                                                        productId:
                                                            currentProduct
                                                                .productID!,
                                                        context: context,
                                                      );
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor: white,
                                                      side: BorderSide(
                                                          color: greyShade3),
                                                    ),
                                                    child: Text(
                                                      'Delete',
                                                      style:
                                                          textTheme.bodySmall,
                                                    ),
                                                  ),
                                                  CommonFunction.blankSpace(
                                                    0,
                                                    width * 0.01,
                                                  ),
                                                  // set the width to a specific value
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor: white,
                                                      side: BorderSide(
                                                        color: greyShade3,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Save later',
                                                      style:
                                                          textTheme.bodySmall,
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
                          ),
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return const Text('Error Found');
                    } else {
                      return const Text('No Product Addet to Cart');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
