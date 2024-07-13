import 'package:flutter/material.dart';
import 'package:yanana/models/gaz/boutiquier_back.dart';
import 'package:yanana/vue/gaz/boutiquiers/waiting_page.dart';
import 'package:yanana/vue/gaz/boutiquiers/listener.dart';
import 'package:yanana/vue/gaz/boutiquiers/gest_boutiquier.dart';
import 'package:provider/provider.dart';
import 'parametre.dart';
import 'package:shimmer/shimmer.dart';

// class implementant l'accueil 
                            //du boutiquier 
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
   /* {
      "page":const Statisique_boutiquier(),
      "titre":"Statistiques"
    },*/
  ];

  var indexCourant=0;

  
  @override
  Widget build(BuildContext context) {
    final ecout = Provider.of<ListenerBoutiq>(context);

   
    if(ecout.getVerifyCompte) return Scaffold(
        appBar:AppBar(
          title: Text("${listPageBoutiquier[indexCourant]["titre"]}",style: TextStyle(color: Colors.black),),
          centerTitle: true,
          
          surfaceTintColor: Colors.black12,
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
          /*BottomNavigationBarItem(
              icon:Icon(Icons.graphic_eq_outlined),
            label:"Statistique",
          ),*/
        ]),
      
      );
      else return WaitingPage();
    
  }
}

// class permettant d'attendre le chargement des datas 
//                                        avant d'afficher la page d'accueil du boutiquier 
                                                                       //ou la page d'attente de verification de compte
class WaitLoadingData extends StatefulWidget{
  const WaitLoadingData({super.key});

  @override
  State<WaitLoadingData> createState() => _WaitLoadingDataState();
}

class _WaitLoadingDataState extends State<WaitLoadingData> {

  @override
  void initState(){
    super.initState();
    BoutiquierBack().recupData(context);
  }

  @override
  Widget build(BuildContext context){

    final ecout = Provider.of<ListenerBoutiq>(context);
    if(ecout.getNonRecupData) 
      return LoadingData();
    else 
      return Accueil_boutiquier();

  }
}


// page implementant le shimmer qui simule l'attente
class LoadingData extends StatelessWidget{
  const LoadingData({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body:Shimmer.fromColors(
        
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade100,
        child:Padding(
          padding:EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context,ind) =>
              Column(
                children: [
                  ListTile(
                    titleTextStyle: TextStyle(height:14.0),
                    contentPadding: EdgeInsets.all(15),
                    tileColor:Colors.grey.shade100,
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    leading:const CircleAvatar(radius:20),
                    title:Container(width:10,color:Colors.red,height:14.0),//  SizedBox(child: Divider(height:30),width:30,height:30)
                    trailing: Container(width:20.0,height:20.0,color:Colors.white),
                  ),
                  SizedBox(height:20)
                ],
              ),
             
            
          ),
        ) ,
      )
    );
  }
}
