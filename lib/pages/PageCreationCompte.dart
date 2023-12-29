import 'package:flutter/material.dart';

class PageCreationCompte extends StatefulWidget {
  const PageCreationCompte({super.key});

  @override
  State<PageCreationCompte> createState() => _PageCreationCompteState();
}

class _PageCreationCompteState extends State<PageCreationCompte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //ici jetend le body derriere lappba que je met a transparent
        extendBodyBehindAppBar:true ,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //couleur des icone a white
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body:Container(
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
            Text("CREATION DE COMPTE",style: TextStyle(color: Colors.white,fontSize: 25),),

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
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(30)),
                              hintText: "Nom"
                          ),
                        ),

                        SizedBox(height: 15,),

                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(30)),
                              hintText: "numéro de téléphone"
                          ),
                        ),

                        SizedBox(height: 15,),

                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(30)),
                              suffixIcon:IconButton(
                                  onPressed: () {

                              }, icon: Icon(Icons.remove_red_eye_rounded,color: Colors.blueAccent.shade700,)),
                              hintText: "Mot de passe"
                          ),

                        ),

                        SizedBox(height: 15,),

                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(30)),
                              suffixIcon:IconButton(
                                  onPressed: () {

                                  }, icon: Icon(Icons.remove_red_eye_rounded,color: Colors.blueAccent.shade700,)),
                              hintText: "Repetez le mot de passe"
                          ),

                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 15,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),

                        onPressed: () {

                        }, child: Text("Créer",style: TextStyle(color: Colors.white),)),
                  ),

                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
