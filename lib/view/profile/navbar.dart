
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer (
      width: MediaQuery.of(context).size.width * 0.65,
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          UserAccountsDrawerHeader(accountName:  Text('Permis 111'), accountEmail:  Text('permis111@gmail.com'),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image(image: AssetImage('assets/images/permis111_1.png'),),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/carousel_permis_slideshow/permis5.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Your Orders'),
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text('Buy Again'),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Your Account'),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('your Wish List'),
          ),
        ],
      ),
    );
  }
}