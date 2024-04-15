import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/controller/provier/address_provider.dart';
import 'package:permis_111/controller/services/notch_pay_services/notch_pay_service.dart';
import 'package:permis_111/controller/services/users_product_services/users_product_servives.dart';
import 'package:permis_111/model/product_model.dart';
import 'package:permis_111/model/transaction_model.dart';
import 'package:permis_111/model/user_product_model.dart';
import 'package:permis_111/pages/widgets/menus/side_menus.dart';
import 'package:permis_111/utils/colors.dart';
import 'package:permis_111/view/user/product_screen/product_screen.dart';
import 'package:provider/provider.dart';

import '../../model/address_model.dart';
import '../user/orders_screen/orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<AddressProvider>(context, listen: false);
            
      },
      child: SafeArea(
        child: Scaffold(
          drawer: const SideMenu(),
          appBar: PreferredSize(
            preferredSize: Size(width, height * 0.08),
            child: Builder(builder: (context) {
              return Container(
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
                    IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu),
                    ),
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
                    
                  ],
                ),
              );
            }),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: width,
              padding: EdgeInsets.symmetric(
                vertical: height * 0.02,
              ),
              child: Column(
                children: [
                  UserGreetingsYouScreen(
                      width: width, textTheme: textTheme, height: height),
                  // CommonFunction.blankSpace(height * 0.01, 0),
                 // YouGridBtons(width: width, textTheme: textTheme),
                  CommonFunction.blankSpace(height * 0.02, 0),
                  UsersOrders(width: width, height: height, textTheme: textTheme),
                  CommonFunction.blankSpace(height * 0.01, 0),
                  CommonFunction.divider(),
                  KeepShopping(
                      width: width, height: height, textTheme: textTheme),
                  CommonFunction.blankSpace(height * 0.01, 0),
                  CommonFunction.divider(),
                  BuyAgain(width: width, height: height, textTheme: textTheme)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KeepShopping extends StatelessWidget {
  const KeepShopping({
    super.key,
    required this.width,
    required this.height,
    required this.textTheme,
  });

  final double width;
  final double height;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.01),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'shooping',
                style:
                    textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Historique',
                  style: textTheme.bodySmall!.copyWith(
                    color: blue,
                  ),
                ),
              ),
            ],
          ),
          CommonFunction.blankSpace(height * 0.01, 0),
          StreamBuilder(
              stream: UsersProductService.fetchKeepShoppingForProducts(),
              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  List<ProductModel> products = snapshot.data!;
                  return products.isEmpty
                      ? Container(
                          height: height * 0.15,
                          width: width,
                          alignment: Alignment.center,
                          child: Text(
                            'rechercher des produits',
                            style: textTheme.bodySmall,
                          ),
                        )
                      : GridView.builder(
                          itemCount:
                              (products.length > 6) ? 6 : products.length,
                          shrinkWrap: true,
                          physics: const PageScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            ProductModel currentProduct = products[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: ProductScreen(
                                        productModel: currentProduct),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: greyShade3,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image(
                                        image: NetworkImage(
                                          currentProduct.imagesURL![0],
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  CommonFunction.blankSpace(height * 0.005, 0),
                                  Text(
                                    currentProduct.name!,
                                    maxLines: 2,
                                    style: textTheme.labelLarge!,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                }

                if (snapshot.hasError) {
                  return Container(
                    height: height * 0.15,
                    width: width,
                    alignment: Alignment.center,
                    child: Text(
                      'Une erreur s’est produite !!',
                      style: textTheme.bodySmall,
                    ),
                  );
                } else {
                  return Container(
                    height: height * 0.15,
                    width: width,
                    alignment: Alignment.center,
                    child: Text(
                      'Aucun produit trouvé !!',
                      style: textTheme.bodySmall,
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}

class BuyAgain extends StatelessWidget {
  const BuyAgain({
    super.key,
    required this.width,
    required this.height,
    required this.textTheme,
  });

  final double width;
  final double height;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.01),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vos commandes',
                style:
                    textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Voir tout',
                  style: textTheme.bodySmall!.copyWith(
                    color: blue,
                  ),
                ),
              ),
            ],
          ),
          CommonFunction.blankSpace(height * 0.01, 0),
          SizedBox(
            height: height * 0.14,
            child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const PageScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: width * 0.3,
                    height: height * 0.14,
                    margin: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: greyShade3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class UsersOrders extends StatelessWidget {
  UsersOrders({
    super.key,
    required this.width,
    required this.height,
    required this.textTheme,
  });

  final double width;
  final double height;
  final TextTheme textTheme;

  Future<List<UserProductModel>> fetchOrders() async {
    final np = NotchPayService();
    final transactions = await np.getTransactions();
    final allApiT = await np.getApiTransactions();
    final apiTransaction = allApiT
        .where((apiTransact) => transactions
            .any((transact) => apiTransact.reference == transact.reference))
        .toList();

    var orders = (await UsersProductService.fetchOrders())
        .where((order) => apiTransaction
            .any((transact) => order.reference == transact.reference))
        .toList();

    return orders;
  }

  Color _getColorStatus(String status) {
    if (status == "pending") {
      return Colors.orange;
    } else if (status == "complete") {
      return Colors.green;
    } else if (status == 'nothing') {
      return Colors.grey;
    }

    return Colors.red;
  }

  String _getStatus(String reference, List<TransactionModel> apiTransaction) {
    final transact = apiTransaction
        .firstWhere((transact) => transact.reference == reference);
    return transact.status ?? 'nothing';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserProductModel>>(
        future: fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Container(
                height: height * 0.15,
                width: width,
                alignment: Alignment.center,
                child: Text(
                  'Opps!! Vous n’avez encore rien acheter!!',
                  style: textTheme.displaySmall,
                ),
              );
            } else {
              List<UserProductModel> orders = snapshot.data!;
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04, vertical: height * 0.01),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Vos achats ',
                          style: textTheme.bodySmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Voir tout',
                            style: textTheme.bodySmall!.copyWith(
                              color: blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CommonFunction.blankSpace(height * 0.01, 0),
                    SizedBox(
                      height: height * 0.2,
                      child: ListView.builder(
                          itemCount: orders.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const PageScrollPhysics(),
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
                                  price: currentProduct.price,
                                  discountedPrice:
                                      currentProduct.discountedPrice,
                                  productID: currentProduct.productID,
                                  productSellerID:
                                      currentProduct.productSellerID,
                                  inStock: currentProduct.inStock,
                                  uploadedAt: currentProduct.time,
                                  discountPercentage:
                                      currentProduct.discountPercentage,
                                );
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: ProductScreen(productModel: product),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: width * 0.3,
                                    height: height * 0.17,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: width * 0.02,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: greyShade3,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image(
                                      image: NetworkImage(
                                          currentProduct.imagesURL![0]),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: NotchPayService()
                                        .getApiTransactions(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        var transacts = snapshot.data!;
                                        if (transacts.isEmpty) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                                  color:
                                                _getColorStatus("nothing"),
                                                ),
                                            child: const Text(
                                              "Nothing",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9.5
                                                  ),
                                            ),
                                          );
                                        } else {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: _getColorStatus(
                                                  _getStatus(
                                                      currentProduct.reference!,
                                                      transacts)),
                                            ),
                                            
                                            child: Text(
                                              _getStatus(
                                                  currentProduct.reference!,
                                                  transacts),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9.5
                                                  ),
                                            ),
                                          );
                                        }
                                      }
                                  
                                      return const SizedBox(
                                        width: 12,
                                        height: 12,
                                        child: CircularProgressIndicator(
                                          color: Colors.blue,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              );
            }
          }
          if (snapshot.hasError) {
            return Container(
              height: height * 0.15,
              width: width,
              alignment: Alignment.center,
              child: Text(
                'Opps!! Une erreur s’est produite',
                style: textTheme.displayMedium,
              ),
            );
          }

          return const SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        });
  }
}

class YouGridBtons extends StatelessWidget {
  const YouGridBtons({
    super.key,
    required this.width,
    required this.textTheme,
  });

  final double width;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 4,
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 4,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (index == 0) {
              Navigator.push(
                context,
                PageTransition(
                  child: const OrdersScreen(),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: grey),
              borderRadius: BorderRadius.circular(50),
              color: greyShade2,
            ),
            alignment: Alignment.center,
            child: Builder(builder: (context) {
              if (index == 0) {
                return Text(
                  'Vos commandes',
                  style: textTheme.bodyMedium,
                );
              }
              if (index == 1) {
                return Text(
                  'Acheter à nouveau',
                  style: textTheme.bodyMedium,
                );
              }
              if (index == 2) {
                return Text(
                  'Votre compte',
                  style: textTheme.bodyMedium,
                );
              }
              return Text(
                'Votre liste de souhaits',
                style: textTheme.bodyMedium,
              );
            }),
          ),
        );
      },
    );
  }
}

class UserGreetingsYouScreen extends StatelessWidget {
  const UserGreetingsYouScreen({
    super.key,
    required this.width,
    required this.textTheme,
    required this.height,
  });

  final double width;
  final TextTheme textTheme;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child:
          Consumer<AddressProvider>(builder: (context, addresPovider, child) {
        if (addresPovider.fetchedCurrentSelectedAddress == true) {
          AddressModel selectedAddress = addresPovider.currentSelectedAddress;
          return Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Bonjour, ', style: textTheme.bodySmall,),
                    TextSpan(
                      text: '${selectedAddress.name}',
                      style: textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CircleAvatar(
                backgroundImage: const AssetImage('assets/images/permis111_2.png'),
                radius: height * 0.025,
              ),
            ],
          );
        } else {
          return Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Bonjour, ', style: textTheme.bodySmall),
                    TextSpan(
                      text: 'Monsieur',
                      style: textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CircleAvatar(
                backgroundColor: greyShade3,
                radius: height * 0.025,
              ),
            ],
          );
        }
      }),
    );
  }
}
