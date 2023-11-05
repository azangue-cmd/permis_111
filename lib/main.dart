import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permis_111/controller/provier/auth_provider/auth_provider.dart';
import 'package:permis_111/firebase_options.dart';
  import 'package:permis_111/utils/theme.dart';
import 'package:permis_111/view/user/user_data_screen/user_data_input_screen.dart';
import 'package:provider/provider.dart';

import 'view/auth_screen/auth_sreen.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        //home: OTPScreen(
         // mobileNumber: '+237610101010',
       // ),
        home: const AuthScreen(),
        //home: const UserBottomNavBar(),
      ),
    );
  }
}
