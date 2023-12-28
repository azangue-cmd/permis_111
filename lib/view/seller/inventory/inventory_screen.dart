import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/controller/provier/product_provider/product_provider.dart';
import 'package:permis_111/model/product_model.dart';
import 'package:permis_111/utils/colors.dart';
import 'package:permis_111/view/seller/add_product_screen/widget/add_product_screen.dart';
import 'package:provider/provider.dart';

import '../../../controller/services/auth_services/function.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SellerProductProvider>().fecthSellerProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () { 
            Navigator.push(
                context,
                PageTransition(
                    child: const AddProductScreen(),
                    type: PageTransitionType.rightToLeft));
          },
          backgroundColor: amber,
          child: Icon(
            Icons.add,
            color: black,
          ),
        ),
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
                Image(
                  image: const AssetImage(
                    'assets/images/permis111_5.png',
                  ),
                  height: height * 0.02,
                ),
                const Spacer(),
                // IconButton(
                //   onPressed: () async {
                //     await disconnect();
                //   },
                //   icon: const Icon(Icons.power),
                // ),
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
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.02,
            ),
            child: Column(
              children: [
                Consumer<SellerProductProvider>(
                  builder: (context, sellerProductProvider, child) {
                    if (sellerProductProvider.sellerProductsFetched == false) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (sellerProductProvider.products.isEmpty) {
                      return Center(
                        child: Text(
                          'No Products Found!',
                          style: textTheme.bodyMedium,
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: sellerProductProvider.products.length,
                      shrinkWrap: true,
                      physics: const PageScrollPhysics(),
                      itemBuilder: (context, index) {
                        ProductModel currentModel = sellerProductProvider
                            .products[index]; 
                        return Container(
                          height: height * 0.35,
                          width: width,
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.01,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: grey,
                            ),
                          ), 
                                child: Column(
                                  children: [
                                    CarouselSlider(
                                      options: CarouselOptions(
                                        height: height * 0.2,
                                        autoPlay: true,   
                                        viewportFraction: 1.0,
                                      ),
                                      items: currentModel.imagesURL!.map((i) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Container(
                                              width: 
                                              MediaQuery.of(context).size.width, 
                                              decoration: BoxDecoration(
                                                color: white,
                                                image: DecorationImage(
                                                  image: NetworkImage(i),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    const Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(currentModel.name!, 
                                                style: textTheme.bodyMedium!.copyWith(
                                                  fontWeight: FontWeight.bold
                                                ),
                                                ),
                                                Text(currentModel.description!, 
                                                maxLines: 2,
                                                style: textTheme.bodySmall!.copyWith(
                                                  overflow: TextOverflow.ellipsis,
                                                  color: grey
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          CommonFunction.blankSpace(0, width * 0.02),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  '${currentModel.price.toString()} frcs', 
                                                style: textTheme.bodyMedium!.copyWith(
                                                  fontWeight: FontWeight.bold
                                                ),
                                                ),
                                                Text(
                                                  currentModel.inStock! ? 'in stock':'Out of stock',
                                                style: textTheme.bodySmall!.copyWith(
                                                  color : currentModel.inStock!
                                                   ? teal
                                                   :red),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      
                                  ],
                                ),
                            
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
