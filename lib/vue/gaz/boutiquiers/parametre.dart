import 'package:flutter/material.dart';
import 'package:yanana/vue/gaz/boutiquiers/parametre/gaz_vendu.dart';
import 'package:yanana/vue/gaz/boutiquiers/parametre/localisation.dart';

class Param extends StatelessWidget{
  const Param({super.key});

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Container(
        padding:EdgeInsets.only(top:50),
        child:Column(
          children: [
            ListTile(
              title:Text('Profil',style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
              onTap: (){},
            ),
            Divider(
              height:0
            ),
            ListTile(
              title:Text('Localisation',style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold)),
              onTap: (){

                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Localisation() )
                );
               locateInstruction(context);
              },
            ),
            Divider(
              height:0
            ),
            ListTile(
              title:Text('Gaz vendu',style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold)),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => GazVendu() )
                );
              },
            ),
            Divider(
              height:0
            ),
            ListTile(
              title:Text('Deconnexion',style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold)),
              onTap: (){},
            ),
            Divider(
              height:0
            )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){}),
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