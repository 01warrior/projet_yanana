import 'package:flutter/material.dart';
import 'package:yanana/vue/page_services.dart';

import 'page_creationCompte.dart';

class Pageconnexion extends StatefulWidget {
  const Pageconnexion({super.key});

  @override
  State<Pageconnexion> createState() => _PageconnexionState();
}

class _PageconnexionState extends State<Pageconnexion> {

  bool seSouvenir=false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //eviter le redimentionnement de lecran notamment lme overflow lors de la sortie du clavier
      resizeToAvoidBottomInset: false,

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.black,
            Colors.blueAccent.shade700
          ],
            begin: Alignment.topCenter,
            end:Alignment.bottomCenter
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/icone_services.png",width: 150,),
            Text("YANANA",style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.w700),),
            Text("SERVICES",style: TextStyle(color: Colors.white,fontSize: 25),),

            Container(
              margin: EdgeInsets.all(25),
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)
                              ),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(30)),

                              prefixIcon:Icon(Icons.person_4,color: Colors.blueAccent.shade700,),
                            hintText: "numéro de téléphone"
                          ),
                        ),

                        SizedBox(height: 15,),

                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(30)),
                            prefixIcon:Icon(Icons.lock,color: Colors.blueAccent.shade700,),
                              hintText: "Mot de passe"
                          ),

                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(

                            activeColor: Colors.blueAccent.shade700,
                            checkColor: Colors.white,
                            value: seSouvenir,

                            onChanged: (value) {
                              setState(() {
                                seSouvenir=value!;
                              });
                            },
                          ),
                          Text("se souvenir de moi",style: TextStyle(fontSize: 12,color: Colors.blueAccent.shade700),)
                        ],
                      )
                    ],
                  ),


                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.black),
                      ),

                        onPressed: () {

                     /*   Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                          return PageServices();
                        },));*/

                    }, child: Text("Se connecter",style: TextStyle(color: Colors.white),)),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      Text("Vous avez pas de compte ?",style: TextStyle(fontSize: 11,),),
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) {
                          return PageCreationCompte();
                        },));
                      }, child: Text("Créer un compte ",style: TextStyle(fontSize: 12,color: Colors.blueAccent.shade700)),)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
