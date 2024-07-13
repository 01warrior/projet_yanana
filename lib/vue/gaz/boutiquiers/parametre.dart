import 'package:flutter/material.dart';
import 'package:yanana/vue/gaz/boutiquiers/parametre/gaz_vendu.dart';
import 'package:yanana/vue/gaz/boutiquiers/parametre/localisation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yanana/vue/gaz/boutiquiers/parametre/contact.dart';

class Param extends StatelessWidget{
  const Param({super.key});

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Container(
        padding:EdgeInsets.all(20),
        child:Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black12
          ),
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white
                  ),
                  child: Icon(Icons.person),
                ),
                title:Text('Profil',style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
                onTap: (){},
              ),
              Divider(
                height:10
              ),
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white
                  ),
                  child: Icon(Icons.map),
                ),
                title:Text('Localisation',style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold)),
                onTap: (){

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Localisation() )
                  );
                 locateInstruction(context);
                },
              ),
              Divider(
                height:10
              ),
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white
                  ),
                  child: Icon(Icons.gas_meter),
                ),
                title:Text('Vos marques de gaz vendu',style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold)),
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GazVendu() )
                  );
                },
              ),
              SizedBox(
                width: 300,
                child: Divider(
                  height:10
                ),
              ),
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white
                  ),
                  child: Icon(Icons.logout,color: Colors.red,),
                ),
                title:Text('Deconnexion',style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold)),
                onTap: (){
                  showDialog(
                    context: context, 
                    builder:(context) => AlertDialog(
                      title:Text('Se déconnecter?'),
                      actions:[
                        TextButton(
                          onPressed:(){FirebaseAuth.instance.signOut();Navigator.of(context).pop();},
                          child:Text('Oui')
                        ),
                        TextButton(
                          onPressed:(){Navigator.of(context).pop();},
                          child:Text('Non')
                        )
                      ]
                    )
                  );
                  
                },
              ),
              Divider(
                height:10
              )
            ],
          ),
        )
      ),
      floatingActionButton:const Contact()
      /*FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.white,
          onPressed: (){
        
      },
      child: Icon(Icons.contact_phone_outlined,),),*/
    );
  }
  locateInstruction(BuildContext context) {
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: Text('Etapes à suivre'),
          content:Text("""Pour une localisation précise de votre lieu de commerce,veuillez suivre ces différentes étapes.

1- Placez-vous au niveau de votre lieu de commerce
2- Veuillez activez votre localistion
3- Cliquer sur le bouton pour commencer le processus
4- Assurer vous de voir le message de confirmation 


          """),
          actionsAlignment: MainAxisAlignment.center,
          actions: [TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('OK',style:TextStyle(fontSize: 25)))],
        );
      }
    );
  }
}
//Text('Pour une localisation précise de votre lieu de commerce,veuillez suivre ces différentes étapes.')