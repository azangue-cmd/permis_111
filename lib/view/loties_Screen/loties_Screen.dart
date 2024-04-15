import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LotieScreen extends StatefulWidget {
  const LotieScreen({super.key});

  @override
  State<LotieScreen> createState() => _LotieScreenState();
}

class _LotieScreenState extends State<LotieScreen> {
  int currentIndex = 0;
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomPaint(
            painter: ArcPainter(),
            child: SizedBox(
              height: screenSize.height / 1.3,
              width: screenSize.width,
            ),
          ),
          Positioned(
            top: 40,
            right: 5,
            left: 5,
            child: Lottie.asset(
              tabs[currentIndex].lotieTitle,
              width: 600,
              alignment: Alignment.topCenter
              // width: 300,
              // fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 180,
              child: Column(
                children: [
                Flexible(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: tabs.length,
                    itemBuilder: (context, index) {
                      OnboardingModel tab = tabs[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            tab.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0
                            ),
                            Text(
                              tab.subtitle,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.center,
                            )
                        ],
                      );
                    },
                    onPageChanged: (value) {
                      currentIndex = value;
                      setState(() {
                        
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < tabs.length; i++)
                     DotIndicator(
                      isSeclected: i == currentIndex,
                    ),
                  ],
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                ]
                ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton( 
        onPressed: () {
          if (currentIndex == 2){
            pageController.animateToPage(0, duration: const Duration(milliseconds: 600), curve: Curves.linear);
          }else{
            pageController.nextPage(duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
          }
        },
        child:  const Icon(
          CupertinoIcons.chevron_right,
          color: Colors.white,
          ),
          
        backgroundColor: Colors.transparent,
      )
      
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // je veux dessiner un arc au millenieu de l'ecran
    
    Path orangeArc = Path()
    ..moveTo(0, 0)
    ..lineTo(0, size.height - 170)
    ..quadraticBezierTo(size.width/2,
     size.height ,size.width, size.height - 170)
    ..lineTo(size.width, size.height)
    ..lineTo(size.width, 0)
    ..close();

    canvas.drawPath(orangeArc, Paint()..color = Color.fromARGB(255, 211, 23, 9));

    Path whiteArc = Path()
    ..moveTo(0.0, 0.0)
    ..lineTo(0.0, size.height - 185)
    ..quadraticBezierTo(size.width / 2, size.height - 70, size.width, size.height - 185)
    ..lineTo(size.width, size.height)
    ..lineTo(size.width, 0)
    ..close();

    canvas.drawPath(whiteArc, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DotIndicator extends StatelessWidget {
  final bool isSeclected;
  const DotIndicator({super.key, required this.isSeclected});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:  const EdgeInsets.only(right: 6.0),
      child: AnimatedContainer(
        height: 6.0, 
        width: 6.0, 
        duration: const Duration(milliseconds: 300), 
        decoration: BoxDecoration(
          shape: BoxShape.circle, 
          color: isSeclected ? Colors.white : Colors.white38,
          ),
          ),
    );

  }
}

class OnboardingModel {
  final String lotieTitle;
  final String title;
  final String subtitle;

   OnboardingModel( this.lotieTitle,  this.title,  this.subtitle);
}

List<OnboardingModel> tabs = [ OnboardingModel(
  'assets/images/loties/Animation - 1711465341634.json',
  'connectez vous pour vous sooigner',
  'OTP connexion rapide et securisee'),
  OnboardingModel(
    'assets/images/loties/Animation - 1711468249579.json',
    'Trouvez Le bon medicament',
    'Pour une sante de fer'),
    OnboardingModel(
    'assets/images/loties/Animation - 1711469042919.json',
    'Payer votre facture',
    'La sante n\'a pas de prix'),
  
];