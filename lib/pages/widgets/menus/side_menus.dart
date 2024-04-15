
import 'package:flutter/material.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/pages/widgets/menus/info_cards.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/services/auth_services/function.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key, });

 

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: 250,
            height: double.infinity,
            color: Colors.red,
            child:  SafeArea(
              child: Column(
                children: [
                  CommonFunction.blankSpace(height * 0.02, 0),
                  const InfoCard(),
                  Column(
                    children: [
                      const Divider(color: Colors.white24, height: 30,),
                      GestureDetector(
                        onTap: _launchURL,
                        child: const ListTile(
                          leading: Icon(Icons.bar_chart_outlined, color: Colors.white,),
                          title: Text('SuperLife', style: TextStyle(color: Colors.white , fontSize: 16),),
                        ),
                      ),
                      
                      SideMenuTitle(
                        isActive: false,
                        title: 'Vos Achats',
                        icon: Icons.inventory_2_outlined,
                        press: () {
                          
                        },
                      ),
                      SideMenuTitle(
                        isActive: false,
                        title: 'Vos commande',
                        icon: Icons.shopping_cart,
                        press: () {
                        },
                      ),
                      
                        SideMenuTitle(
                          isActive: false,
                        title: 'your Wish List',
                        
                        icon: Icons.favorite,
                        press: () {
                          
                        },
                      ),
                        
                        const Divider(color: Colors.white24, height: 60,),
                        SideMenuTitle(
                          isActive: false,
                        title: 'Parametres',
                        icon: Icons.settings,
                        press: () {
                          
                        },
                      ),
                        SideMenuTitle(
                          isActive: false,
                        title: 'Deconexion',
                        icon: Icons.logout,
                        press: () async{
                          await disconnect();
                        },
                      ),
                      
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SideMenuTitle extends StatefulWidget {
   const SideMenuTitle({
    super.key, required this.title, required this.icon, required this.press, required this.isActive,
  });

final bool isActive ;
final String title;
final IconData icon;
final VoidCallback press;

  @override
  State<SideMenuTitle> createState() => _SideMenuTitleState();
}

class _SideMenuTitleState extends State<SideMenuTitle> 
with SingleTickerProviderStateMixin{
late AnimationController _controller;
  late Animation<double> _animation;
   @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 250).animate(_controller);

    if (widget.isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
   @override
  void didUpdateWidget(SideMenuTitle oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return  Column(
     
        children: [
         const Padding(padding:  EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.transparent,
            height: 1),
          ),
         
           Stack(
             children: [
              AnimatedPositioned(
                duration:  const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                left: 0,
                width: widget.isActive ? 250 : 0,
                height: 56,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20)
                    ),
                  )
                ),
              ),
               ListTile(
                onTap: widget.press,
                leading: Icon(widget.icon, color: Colors.white,),
                title: Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 16),),
                
                         ),
             ],
           ),
        ],
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

