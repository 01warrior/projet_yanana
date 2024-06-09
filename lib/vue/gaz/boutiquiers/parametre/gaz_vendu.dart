import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanana/models/gaz/boutiquier_back.dart';
import 'package:yanana/vue/gaz/boutiquiers/listener.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class GazVendu extends StatelessWidget{
   GazVendu({super.key});
  
  final id = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context){
    final ec = Provider.of<ListenerBoutiq>(context);
    // VOIR APRES POUR QUE QUAND UN GAZ EST DECLARER NON VENDU SET SA VAR DISPO A FALSE :::::
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          Text('Liste des gaz',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          SizedBox(height:12.0),
          ListTile(
            title: Text('Oryx',style:TextStyle(fontSize: 20) ,),
            trailing: Checkbox(
              value: ec.getVendOryx, 
              onChanged: (ch){
                showDialog(  // VOIR COMMENT SIMPLIFIER LE CODE EN UTILISANT LE MEME SHOWDIALOG POUR TOUT LES CAS
                  context: context, 
                  builder: (context){
                    return AlertDialog(
                      title: Text('Valider?'),
                      actions: [
                        TextButton(
                          onPressed: ()async{
                            ch != null ? ec.setVendOryx = ch : null ;
                            await BoutiquierBack().updateGazVendu(context: context, gaz6: 'Oryx6', gaz12:'Oryx12', ch: ch!);
                            Navigator.of(context).pop();
                          }, 
                          child: Text('Oui')
                        ),
                        TextButton(
                          onPressed: (){Navigator.of(context).pop(); }, 
                          child: Text('Non')
                        )
                      ],
                    );
                  }
                );
                
                
              }),
          ),
          ListTile(
            title: Text('Total',style:TextStyle(fontSize: 20)),
            trailing: Checkbox(
              value: ec.getVendTotal, 
              onChanged: (ch)async{
                showDialog(
                  context: context, 
                  builder: (context){
                    return AlertDialog(
                      title: Text('Valider?'),
                      actions: [
                        TextButton(
                          onPressed: ()async{
                            ch != null ? ec.setVendTotal = ch : null ;
                            await BoutiquierBack().updateGazVendu(context: context, gaz6: 'Total6', gaz12:'Total12', ch: ch!);
                            Navigator.of(context).pop();
                          }, 
                          child: Text('Oui')
                        ),
                        TextButton(
                          onPressed: (){Navigator.of(context).pop(); }, 
                          child: Text('Non')
                        )
                      ],
                    );
                  }
                );
                
               
              }
            ),
          ),
          ListTile(
            title: Text('Sodigaz',style:TextStyle(fontSize: 20)),
            trailing: Checkbox(
              value: ec.getVendSodigaz, 
              onChanged: (ch)async{
                showDialog(
                  context: context, 
                  builder: (context){
                    return AlertDialog(
                      title: Text('Valider?'),
                      actions: [
                        TextButton(
                          onPressed: ()async{
                            ch != null ? ec.setVendSodigaz = ch : null ;
                            await BoutiquierBack().updateGazVendu(context: context, gaz6: 'Sodigaz6', gaz12:'Sodigaz12', ch: ch!);
                            Navigator.of(context).pop();
                          }, 
                          child: Text('Oui')
                        ),
                        TextButton(
                          onPressed: (){Navigator.of(context).pop(); }, 
                          child: Text('Non')
                        )
                      ],
                    );
                  }
                );
                
                
              }
            ),
          ),
          ListTile(
            title: Text('Pegaz',style:TextStyle(fontSize: 20)),
            trailing: Checkbox(
              value: ec.getVendPegaz, 
              onChanged: (ch)async{
                showDialog(
                  context: context, 
                  builder: (context){
                    return AlertDialog(
                      title: Text('Valider?'),
                      actions: [
                        TextButton(
                          onPressed: ()async{
                            ch != null ? ec.setVendPegaz = ch : null ;
                            await BoutiquierBack().updateGazVendu(context: context, gaz6: 'Pegaz6', gaz12:'Pegaz12', ch: ch!);
                            Navigator.of(context).pop();
                          }, 
                          child: Text('Oui')
                        ),
                        TextButton(
                          onPressed: (){Navigator.of(context).pop(); }, 
                          child: Text('Non')
                        )
                      ],
                    );
                  }
                );
                
               
              }
            ),
          )
        ],
      ),
    );
  }
}