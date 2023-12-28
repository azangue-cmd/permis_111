import 'dart:math';

import 'package:flutter/material.dart';
import 'package:permis_111/controller/provier/user_product_provider/users_product_provider.dart';
import 'package:permis_111/controller/services/product_services/product_services.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';

// class SearchProductDisplayScreen extends StatelessWidget {
//   const SearchProductDisplayScreen({super.key, required this.width});
//   final double width;

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     final textTheme = Theme.of(context).textTheme;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         SizedBox(

//           //width: width * 0.8,
//           child: IconButton(onPressed: (){
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back, color: black,)),
//           // TextField(
//           //   onTap: () {},
//           //   cursorColor: black,
//           //   decoration: InputDecoration(
//           //     fillColor: white,r
//           //     filled: true,
//           //     hintText: 'Search Permis111.in',
//           //     prefixIcon: IconButton(
//           //       onPressed: () {},
//           //       icon: Icon(
//           //         Icons.search,
//           //         color: black,
//           //       ),
//           //     ),
//           //     suffixIcon: IconButton(
//           //       onPressed: () {},
//           //       icon: Icon(
//           //         Icons.camera_alt_sharp,
//           //         color: grey,
//           //       ),
//           //     ),
//           //     contentPadding: EdgeInsets.symmetric(horizontal: width * 0.03),
//           //     border: OutlineInputBorder(
//           //       borderRadius: BorderRadius.circular(16),
//           //       borderSide: BorderSide(color: grey),
//           //     ),
//           //     focusedBorder: OutlineInputBorder(
//           //       borderRadius: BorderRadius.circular(16),
//           //       borderSide: BorderSide(color: grey),
//           //     ),
//           //     enabledBorder: OutlineInputBorder(
//           //       borderRadius: BorderRadius.circular(16),
//           //       borderSide: BorderSide(color: grey),
//           //     ),
//           //     disabledBorder: OutlineInputBorder(
//           //       borderRadius: BorderRadius.circular(16),
//           //       borderSide: BorderSide(color: grey),
//           //     ),
//           //     errorBorder: OutlineInputBorder(
//           //       borderRadius: BorderRadius.circular(16),
//           //       borderSide: BorderSide(color: grey),
//           //     ),
//           //   ),
//           // ),
//         ),
//         TextField(),
//         IconButton(
//           onPressed: () {
//           },
//           icon: Icon(
//             Icons.mic,
//             color: black,
//           ),
//         ),
//       ],
//     );
//   }
// }

class SearchProductDisplayScreen extends StatefulWidget {
  const SearchProductDisplayScreen({super.key});

  @override
  State<SearchProductDisplayScreen> createState() =>
      _SearchProductDisplayScreenState();
}

class _SearchProductDisplayScreenState
    extends State<SearchProductDisplayScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          // width: width * 0.8,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: black,
              )),
          // TextField(
          //   onTap: () {},
          //   cursorColor: black,
          //   decoration: InputDecoration(
          //     fillColor: white,r
          //     filled: true,
          //     hintText: 'Search Permis111.in',
          //     prefixIcon: IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.search,
          //         color: black,
          //       ),
          //     ),
          //     suffixIcon: IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.camera_alt_sharp,
          //         color: grey,
          //       ),
          //     ),
          //     contentPadding: EdgeInsets.symmetric(horizontal: width * 0.03),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(16),
          //       borderSide: BorderSide(color: grey),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(16),
          //       borderSide: BorderSide(color: grey),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(16),
          //       borderSide: BorderSide(color: grey),
          //     ),
          //     disabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(16),
          //       borderSide: BorderSide(color: grey),
          //     ),
          //     errorBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(16),
          //       borderSide: BorderSide(color: grey),
          //     ),
          //   ),
          // ),
        ),
        SizedBox(
          width: width * 0.65,
          child: TextField(
            controller: searchController,
            onSubmitted: (productName) {
              context
                  .read<UsersProductProvider>()
                  .getSearchedProducts(productName: productName);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: width * 0.03),
              filled: true,
              fillColor: white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: grey),
              ),
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.mic,
            color: black,
          ),
        ),
      ],
    );
  }
}
