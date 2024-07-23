import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:yanana/vue/gaz/services/accueil_gaz.dart';
import 'package:yanana/vue/widget/animation_fade.dart';


class PageServices extends StatefulWidget {
  const PageServices({super.key});

  @override
  State<PageServices> createState() => _PageServicesState();
}

class _PageServicesState extends State<PageServices> {

  late final StreamSubscription<InternetConnectionStatus> ecouteurReseau;
  @override
  void initState() {
    super.initState();

    //-------------------------------initialisation de lecouteur du reseau lors de linitialisation de letat------------------
    ecouteurReseau=InternetConnectionChecker().onStatusChange.listen((status) {

      switch (status) {
        case InternetConnectionStatus.connected:
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  behavior:SnackBarBehavior.floating,
                  backgroundColor: Colors.green,content: Text("Vous etes à nouveau connecté")
              )
          );
          break;
        case InternetConnectionStatus.disconnected:
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  behavior:SnackBarBehavior.floating,
                  backgroundColor: Colors.red,content: Text("Reseau perdu! Vous etes hors connexion")
              )
          );
          break;
      }
    });

  }

  var listImages=const[Image(image: AssetImage("assets/images/icone_gaz.png"),width: 100,), Icon(Icons.question_mark,size:100),
     Icon(Icons.question_mark,size:100), Icon(Icons.question_mark,size:100)];//liste des images des diff services
  var listName=["Gaz","A venir","A venir","A venir"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        elevation: 1,
        centerTitle: true,
        title: Text("Services",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),

        
        backgroundColor: Colors.black26,
      ),

      body: Column(
        children: [
          FadeInWidget(
            direction: "top",
            child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              height: 150,
              width: double.infinity,

              decoration: BoxDecoration(
                image: DecorationImage(image:AssetImage("assets/images/place_martyrs.png")),
                color: Colors.black12,
                borderRadius: BorderRadius.circular(15)
              ),

              child:Text("Facilitez vous la vie",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,fontFamily: "Poppins"),),
            ),
          ),

          GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,

              ),
              shrinkWrap:true,
            itemCount: 4,
            itemBuilder: ((context, index) {
              return FadeInWidget(
                direction: index==0?"left":index==1?"right":index==2?"bottom":"bottom1",
                child: InkWell(

                  onTap: () {
                    index==0?Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AccueilGaz();
                    },)):null;
                  },

                  child: Container(

                    margin:const EdgeInsets.all(5),
                    padding:const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15)
                    ),

                    child: Column(
                      children: [
                       listImages[index],
                        Divider(color: Colors.black38),
                        Text(listName[index],style: TextStyle(color: Colors.black45,fontFamily: "Poppins"))
                      ],
                    ),
                  ),
                ),
              );
            })),
       

        ],
      ),
    );
  }
}
