import 'package:flutter/material.dart';
import 'package:yanana/vue/gaz/boutiquiers/gestion_boutiquier.dart';
import 'package:yanana/vue/gaz/boutiquiers/listener.dart';
import 'package:yanana/vue/gaz/boutiquiers/statisique_boutiquier.dart';
import 'package:yanana/vue/gaz/boutiquiers/gest_boutiquier.dart';
import 'package:provider/provider.dart';
import 'parametre.dart';
class Accueil_boutiquier extends StatefulWidget {
  const Accueil_boutiquier({super.key});

  @override
  State<Accueil_boutiquier> createState() => _Accueil_boutiquierState();
}

class _Accueil_boutiquierState extends State<Accueil_boutiquier> {

  List listPageBoutiquier=[
    {
      "page":const GestBoutiquier(),
      "titre":"Gestion"
    },

    {
      "page":const Param(),
      "titre":"Parametre"
    },

    {
      "page":const Statisique_boutiquier(),
      "titre":"Statistiques"
    },



  ];

  var indexCourant=0;

 /* @override
  void initState(){
    super.initState();
    BoutiquierBack().recupData();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Text("${listPageBoutiquier[indexCourant]["titre"]}",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton.outlined(
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
                  onPressed: () {
      
                  }, icon: Icon(Icons.person,color: Colors.blueAccent.shade700,size: 30,)),
            )
          ],
      
          backgroundColor: Colors.black87,
        ),
      
        body: listPageBoutiquier[indexCourant]["page"],
      
        bottomNavigationBar: BottomNavigationBar(
      
          selectedIconTheme: IconThemeData(
            size:35
          ),
      
          selectedFontSize: 18,
      
          currentIndex:indexCourant,
      
            onTap:(value) {
              setState(() {
                indexCourant=value;
              });
            },
      
            items: const [
          BottomNavigationBarItem(
              icon:Icon(Icons.home),
            label:"Accueil",
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.manage_history_rounded),
            label:"Parametre",
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.graphic_eq_outlined),
            label:"Statistique",
          ),
        ]),
      
      );
    
  }
}
