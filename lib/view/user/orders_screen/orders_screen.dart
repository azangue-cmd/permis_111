import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permis_111/controller/services/users_product_services/users_product_servives.dart';
import 'package:permis_111/model/user_product_model.dart';

import '../../../model/product_model.dart';
import '../../../utils/colors.dart';
import '../product_screen/product_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(width, height * 0.08),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.03, vertical: height * 0.01),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: appBarGradientColor,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              children: [
                // IconButton(
                //   onPressed: () => Scaffold.of(context).openDrawer(),
                //   icon: const Icon(Icons.menu),
                // ),
                Image(
                  image: const AssetImage(
                    'assets/images/permis111_5.png',
                  ),
                  height: height * 0.02,
                ),
                const Spacer(),

                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                    size: height * 0.035,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: height * 0.035,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: StreamBuilder<List<UserProductModel>>(
          stream: UsersProductService.fetchOrdersAsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'Please order Something',
                    style: textTheme.bodyLarge,
                  ),
                );
              } else {
                List<UserProductModel> orders = snapshot.data!;
                ListView.builder(
                  itemCount: orders.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    UserProductModel currentProduct = orders[index];
                    return InkWell(
                      onTap: () {
                        ProductModel product = ProductModel(
                          imagesURL: currentProduct.imagesURL,
                          name: currentProduct.name,
                          category: currentProduct.category,
                          description: currentProduct.description,
                          brandName: currentProduct.brandName,
                          manufacturerName: currentProduct.manufacturerName,
                          countryOfOrigin: currentProduct.countryOfOrigin,
                          specifications: currentProduct.specifications,
                          price: currentProduct.price,
                          discountedPrice: currentProduct.discountedPrice,
                          productID: currentProduct.productID,
                          productSellerID: currentProduct.productSellerID,
                          inStock: currentProduct.inStock,
                          uploadedAt: currentProduct.time,
                          discountPercentage: currentProduct.discountPercentage,
                        );
                        Navigator.push(
                          context,
                          PageTransition(
                            child: ProductScreen(productModel: product),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.1,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: grey,
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: width * 0.03,
                          vertical: height * 0.01,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03,
                          vertical: height * 0.01,
                        ),
                        child: Row(
                          children: [
                            Image(
                              image: NetworkImage(currentProduct.imagesURL![0]),
                              fit: BoxFit.fitHeight,
                            ),
                            const Spacer(),
                            Text(
                              currentProduct.productCount!.toStringAsFixed(0),
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              // return ListView.builder(
              //   itemCount: snapshot.data.docs.length,
              //   itemBuilder: (context, index){
              //     return ListTile(
              //       title: Text(snapshot.data.docs[index]['name']),
              //       subtitle: Text(snapshot.data.docs[index]['price']),
              //     );
              //   },
              // );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Opps!! There is an Error',
                  style: textTheme.bodyMedium,
                ),
              );
            } else {
              return Center(
                child: Text(
                  'Opps!! Unable to fetch Orders',
                  style: textTheme.bodyMedium,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
