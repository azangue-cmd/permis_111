import 'package:flutter/material.dart';
import 'package:permis_111/utils/theme.dart';
import 'package:permis_111/view/auth_screen/auth_sreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}


