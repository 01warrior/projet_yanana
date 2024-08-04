import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yanana/models/gaz/boutiquier_back.dart';
import 'package:yanana/vue/gaz/connexion/page_connexion.dart';
import 'package:yanana/vue/gaz/services/page_recherche_gaz.dart';

// PAGE D'ACCUEIL QUAND USER CLIQUE
//                                  SUR L'ICONE GAZ DANS L'APP

class AccueilGaz extends StatefulWidget{
  const AccueilGaz({super.key});

  @override
  State<AccueilGaz> createState() => _AccueilGazState();
}

class _AccueilGazState extends State<AccueilGaz> {


  @override
  void initState(){
    super.initState();
    BoutiquierBack().recupVille(context: context);
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton.outlined(
              style:const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                  return VerifConnexion();
                },));
            }, icon: Icon(Icons.person,color: Colors.blueAccent.shade700,size: 20,)),
          ),
          
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(alignment: Alignment.center,
                            children:[

                              const SpinKitDoubleBounce(
                                color: Colors.orange,
                                size: 210.0,
                              ),SizedBox(height:150 ,
                                width: 150,
                                child:

                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:MaterialStatePropertyAll(Colors.green.shade400) ,
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100)
                                          ))
                                  ),
                                  onPressed:() async {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) =>const PageServiceGaz())
                                    );
                                  },
                                  child: const Text('Trouver ',style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Poppins"),),
                                ),)
                            ]
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),

      ));

  }
}