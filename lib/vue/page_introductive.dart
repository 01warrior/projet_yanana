import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yanana/vue/page_services.dart';

class PageIntroductive extends StatefulWidget {
  const PageIntroductive({super.key});

  @override
  State<PageIntroductive> createState() => _PageIntroductiveState();
}

class _PageIntroductiveState extends State<PageIntroductive> {

  final List slider=[
    Container(
      padding: EdgeInsets.all(20),
      color: Colors.white70,
      child: Center(child: Text("Bienvenue sur YANANA votre application qui vous facilite la vie")),
    ),
    Container(
      padding: EdgeInsets.all(20),
      color: Colors.blue.shade700,
      child: Center(child: Text("Vous avez besoins des point de recharge de gaz pour eviter de tourner dans tout les point de recharge de ouaga ?")),
    ),
    Container(
      padding: EdgeInsets.all(20),
      color: Colors.black87,
      child: Center(child: Text("Vous etes en pane et vous avez besoin d'un depaneur le plus proche de votre position?")),
    )
  ];

  Timer? compteur;
  int pageCourant=0;
  final PageController _pageControleur=PageController(initialPage: 0);

  fonctionDeDiaporama()
  {
    //j'initialise avec une fonction qui vas faire une faire passer la page apres deux seconde
    Timer.periodic(Duration(seconds: 4), (Timer compteur) {

      if(pageCourant<slider.length-1)
      {
        pageCourant++;
        _pageControleur.animateToPage(pageCourant, duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
      }
      else
      {
        //si la fin des slider est atteint je lenvoie dans la page daccueil services
        // en fermant bient sur le compteur sans quoi il vas continuer a sexecuter en arriere plan
        compteur.cancel();

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PageServices();
        },));
      }

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fonctionDeDiaporama();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(

        controller:_pageControleur,
        itemCount: slider.length,
        itemBuilder: (context, index) {
          return slider[index];
        },

        onPageChanged: (value) {
          setState(() {
            pageCourant=value;

            //_______________________________________________A revoir--------------------------------------
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: slider.length,
              itemBuilder: (context, index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.all(5),width: 60,height: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: pageCourant==index?Colors.white70:Colors.grey
                    ),
                  ),
                );

              },);


          });


        },
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          SizedBox(
            width: 120,
            child: FloatingActionButton(
              onPressed: () {
                //si la personne souhaite passer je louvre directement la page
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PageServices();
                },));

            },
            child: Text("passer"),
            ),

          )

        ],
      )
    );
  }
}
