import 'package:flutter/material.dart';
import 'package:permis_111/utils/colors.dart';

import '../../../controller/services/auth_services/function.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
      final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
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
        body: Center(
          child: Text(
            'Inventory'
            ),
        ),
      ),
    );
  }
}
