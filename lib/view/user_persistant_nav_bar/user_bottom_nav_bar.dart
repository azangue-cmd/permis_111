import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/colors.dart';
import '../profile/profile_sreen.dart';
import '../user/cart/cart_screen.dart';
import '../user/home/home_screen.dart';
import '../user/menu/menu_screen.dart';

class UserBottomNavBar extends StatefulWidget {
  const UserBottomNavBar({super.key});

  @override
  State<UserBottomNavBar> createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const ProfileScreen(),
      const CartScreen(),
      GestureDetector(
        onTap: _launchURL,
        child: Center(
          child:  Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: amber,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                'SuperLife',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ),
     
      //const MenuScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: "Acceille",
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: "Profile",
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart),
        title: "Pagnier",
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bar_chart_outlined),
        title: "SuperLife",
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: black,
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(Icons.menu),
      //   title: "Menu",
      //   activeColorPrimary: kPrimaryColor,
      //   inactiveColorPrimary: black,
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3,
    );
  }
}
void _launchURL() async {
  const url = 'https://office.superlifeworld.com.my/index.php/site/home';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Oops!! imposible de se connecter a $url';
  }
}