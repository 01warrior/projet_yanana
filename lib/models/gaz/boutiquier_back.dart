import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yanana/vue/gaz/boutiquiers/listener.dart';
import 'package:provider/provider.dart';
class  BoutiquierBack {

  String id = FirebaseAuth.instance.currentUser!.uid;
  
  var nomGaz =["Oryx6","Oryx12","Total6","Total12","Sodigaz6","Sodigaz12","Pegaz6","Pegaz12"];
  recupData(BuildContext context)async{
    final ecoutStock = Provider.of<ListenerBoutiq>(context,listen: false);
    print(id);
    if(ecoutStock.getNonRecupData){
      
      var db = FirebaseFirestore.instance.collection('users').doc(id).collection('gaz');
      await db.get()
      .then((value) {
        ecoutStock.setNonRecupData=false;
        if(value.size ==0 ){
          for(var n in nomGaz){
            db.doc(n).set( {'quantite':0},SetOptions(merge: true));
          }
          
        }
        else{
          debugPrint(" Ton batard ");
          for( var doc in value.docs ){
            var dat = doc.data() ;
            if(doc.id == nomGaz[0]){
              ecoutStock.setQteOryx6 = dat["quantite"] ;
            }else if(doc.id == "Oryx12"){
              ecoutStock.setQteOryx12 = dat['quantite'] ;
            }else if(doc.id == "Total6"){
              ecoutStock.setQteTotal6 = dat["quantite"];
            }else if(doc.id == "Total12"){
              ecoutStock.setQteTotal12 = dat["quantite"];
            }else if(doc.id == "Sodigaz6"){
              ecoutStock.setQteSodigaz6 = dat["quantite"];
            }else if(doc.id == nomGaz[5]){
              ecoutStock.setQteSodigaz12 = dat["quantite"];
            }else if(doc.id == nomGaz[6]){
              ecoutStock.setQtePegaz6 = dat["quantite"];
            }else if(doc.id == nomGaz[7]){
              ecoutStock.setQtePegaz12 = dat["quantite"];
            }
          }
        }
      },onError: (e){ecoutStock.setNonRecupData=true;}).timeout(const Duration(seconds: 10));
    }
  }



  Future<bool> ajoutStock({required BuildContext context, required String nomGaz,required int nombre})async{
    bool upd=true;
    await FirebaseFirestore.instance.collection('users').doc(id)
    .collection('gaz').doc(nomGaz).update({'quantite':nombre}).then(
      (value){debugPrint('it completed' );},onError: (e){upd=false; debugPrint('maudia error update');}
    ).timeout(const Duration(seconds:5),onTimeout:(){debugPrint(' //////////////Timeout batard');});
    if(upd){
      final ecoutStock = Provider.of<ListenerBoutiq>(context,listen: false);
      if(nomGaz == 'Oryx12'){
       ecoutStock.setQteOryx12=nombre;
      }else if(nomGaz == 'Oryx6'){ecoutStock.setQteOryx6=nombre;}
      else if(nomGaz == 'Total12'){ ecoutStock.setQteTotal12=nombre;}
      else if(nomGaz == 'Total6'){ecoutStock.setQteTotal6=nombre;}
      else if(nomGaz == 'Sodigaz12'){ ecoutStock.setQteSodigaz12=nombre;}
      else if(nomGaz == 'Pegaz12'){ ecoutStock.setQtePegaz12=nombre;}
      else if(nomGaz == 'Sodigaz6'){ ecoutStock.setQteSodigaz6=nombre;}
      else if(nomGaz == 'Pegaz6'){ ecoutStock.setQtePegaz6=nombre;}     
    }
    return upd;
  }
}