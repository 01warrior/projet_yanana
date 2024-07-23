import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


//PAGE SUR LEQUEL LE USER PATIENTE EN ATTENDANT QUE
//                                             SON COMPTE SOIT VALIDER

class WaitingPage extends StatelessWidget{
  const WaitingPage({super.key});

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title:Text('verif ismo modiaaaaaaaa')
      ),
<<<<<<< HEAD
      body:const Placeholder()
=======
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            LottieBuilder.asset("assets/images/waiting_compte.json",),
            DefaultTextStyle(
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 18.0,
                color:Colors.black87,
              ), child: AnimatedTextKit(
              pause:Duration(seconds: 4) ,
              totalRepeatCount: 8,
              animatedTexts: [
                TypewriterAnimatedText(
                  speed: Duration(milliseconds:50),
                  'Veuillez patienter votre compte est en cours de vérification. Une fois verifié vous aurez accès à votre tableau de bord',
                  textAlign: TextAlign.center,
                ),
              ],
              isRepeatingAnimation: true,

              onTap: () {
                print("Tap Event");
              },
            ),),
          ],
        ),
      )
>>>>>>> 04ea8783fc34de96e5fadb27bb4c3358d5f2ec09
    );
  }
}