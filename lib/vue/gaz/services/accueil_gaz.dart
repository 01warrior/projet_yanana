import 'package:flutter/material.dart';
import 'package:yanana/vue/gaz/connexion/page_connexion.dart';
import 'package:yanana/vue/gaz/services/page_service_gaz.dart';



class AccueilGaz extends StatelessWidget{
  const AccueilGaz({super.key});

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Page_service_gaz())
              );
            }, 
            child: Text('search')
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton.outlined(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                  return VerifConnexion();
                },));
            }, icon: Icon(Icons.person,color: Colors.blueAccent.shade700,size: 20,)),
          ),
          
        ],
      ),
      body:const Placeholder()
    );
  }
}