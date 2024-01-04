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
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/icone_intro/homme.png",width: 250,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(height: 80,),
              ),
              Text("Bienvenue sur YANANA votre application qui vous facilite la vie sur plusieurs plans.",style: TextStyle(fontWeight: FontWeight.bold,fontSize:18,fontFamily: "Poppins"),textAlign: TextAlign.center,),
            ],
          )
      ),
    ),

    Container(
      padding: EdgeInsets.all(20),
      color: Colors.blue.shade700,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/icone_intro/icone_terre.png",width: 250,),
              const SizedBox(height: 80,),
              const Text("Localiser les point de recharge de gaz les plus proche pour eviter de tourner dans toute la ville de ouaga.",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize:18 ,fontFamily: "Poppins"),textAlign: TextAlign.center,),
            ],
          )
      ),
    ),

    Container(
      padding: EdgeInsets.all(20),
      color: Colors.cyan,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/icone_intro/technique.png",width: 250,),
              SizedBox(height: 80,),
              const Text("Vous etes en panne et vous avez besoin d'un depaneur le plus proche de votre position ?",style: TextStyle(fontWeight: FontWeight.bold,fontSize:18,fontFamily: "Poppins"),textAlign: TextAlign.center,),
            ],
          )
      ),
    )
  ];


  int pageCourant=0;

  final PageController _pageControleur=PageController(initialPage: 0);

  /*  On vas se passer du diapo finalement

  fonctionDeDiaporama()
  {
    //j'initialise avec une fonction qui vas faire une faire passer la page apres 10 seconde
    Timer.periodic(Duration(seconds: 10), (Timer compteur) {

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

  */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fonctionDeDiaporama();
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

          });


        },
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          /*  SizedBox(
            width: 110,
            height: 50,
            child: FloatingActionButton(

              onPressed: () {
                //si la personne souhaite passer je louvre directement la page
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PageServices();
                },));

            },
            child: Text("passer"),
            ),

          ),  */

          SizedBox(
            width: 110,
            height: 50,
            child: FloatingActionButton(
              onPressed: () {

                if(pageCourant<slider.length-1)
              {
                pageCourant++;
                _pageControleur.animateToPage(pageCourant, duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
              }
              else
              {

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PageServices();
                },));
              }

              },
              child: Text("Suivant",style: TextStyle(color: Colors.black87,fontFamily: "Poppins"),),
            ),

          )

        ],
      )
    );
  }
}
