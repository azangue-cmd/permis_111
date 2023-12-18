import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permis_111/controller/provier/address_provider.dart';
import 'package:permis_111/controller/provier/auth_provider/auth_provider.dart';
import 'package:permis_111/controller/provier/product_provider/product_provider.dart';
import 'package:permis_111/controller/services/auth_services/signInLogic.dart';
import 'package:permis_111/firebase_options.dart';
import 'package:permis_111/utils/theme.dart';
import 'package:permis_111/view/auth_screen/auth_sreen.dart';
import 'package:permis_111/view/seller/seller_persistant_nav_bar/seller_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import 'view/seller/add_product_screen/widget/add_product_screen.dart';
import 'view/user_persistant_nav_bar/user_bottom_nav_bar.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<AddressProvider>(create: (_) => AddressProvider()),
        ChangeNotifierProvider<SellerProductProvider>(create: (_) => SellerProductProvider()),
      ],
      child: MaterialApp(
          theme: theme,
          debugShowCheckedModeBanner: false,
          //home: OTPScreen(
          // mobileNumber: '+237610101010', verificationId: '',
        //  ),
       
          // home: StreamBuilder<User?>(
          //   stream: auth.authStateChanges(),
          //   builder: (context, snapshot) {
          //     return snapshot.data == null ? const AuthScreen() : const UserBottomNavBar();
          //   },
          // ),
          
           //home: const AddProductScreen()
          //home: const UserBottomNavBar(),
           home: const SellerBottomNavBar(),
          //home: const AddProductScreen()
         // home: const SignInLogic()
          ),
    );
  }
}
