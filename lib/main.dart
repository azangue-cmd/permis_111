import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permis_111/controller/provier/address_provider.dart';
import 'package:permis_111/controller/provier/auth_provider/auth_provider.dart';
import 'package:permis_111/controller/provier/deal_of_the_day_provider/deal_of_the_provider.dart';
import 'package:permis_111/controller/provier/product_by_category_provider/product_by_category_provider.dart';
import 'package:permis_111/controller/provier/product_provider/product_provider.dart';
import 'package:permis_111/controller/provier/rating_provider/rating_provider.dart';
import 'package:permis_111/controller/provier/user_product_provider/users_product_provider.dart';
import 'package:permis_111/controller/services/auth_services/signInLogic.dart';
import 'package:permis_111/firebase_options.dart';
import 'package:permis_111/pages/splash_screen/splashscreen.dart';
import 'package:permis_111/utils/theme.dart';
import 'package:permis_111/view/chatbot.dart';
import 'package:permis_111/view/loties_Screen/loties_Screen.dart';
import 'package:permis_111/view/profile/profile_sreen.dart';
import 'package:permis_111/view/searched_product_screen/searched_product_screen.dart';
import 'package:permis_111/view/user/address_screen/address_screen.dart';
import 'package:permis_111/view/user/cart/cart_screen.dart';
import 'package:permis_111/view/user/orders_screen/orders_screen.dart';
import 'package:permis_111/view/user/paiement/paiement.dart';
import 'package:permis_111/view/user/product_screen/product_screen.dart';
import 'package:provider/provider.dart';
import 'view/auth_screen/auth_sreen.dart';
import 'view/seller/add_product_screen/widget/add_product_screen.dart';
import 'view/seller/seller_persistant_nav_bar/seller_bottom_nav_bar.dart';
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
        ChangeNotifierProvider<UsersProductProvider>(create: (_) => UsersProductProvider()),
        ChangeNotifierProvider<DealOfTheDayProvider>(create: (_) => DealOfTheDayProvider()),
        ChangeNotifierProvider<ProductsBasedOnCategoryProvider>(create: (_) => ProductsBasedOnCategoryProvider()),
        ChangeNotifierProvider<RatingProvider>(create: (_) => RatingProvider()),
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
          //     return snapshot.data == null ? const AuthScreen() : const SignInLogic();
          //   },
          // ),
          
            //home: const Chatbot()
          //home: const PaymentScreen(),
           //home: const AddProductScreen()
          //home: const UserBottomNavBar(),
          //home: const SellerBottomNavBar(),
         home: const LotieScreen()
         // home: const SignInLogic()
          ),
    );
  }
}