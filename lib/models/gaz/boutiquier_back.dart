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
          for(var n in nomGaz){//PERMET D'ENR TOUT LES GAZ DISPO DANS LA BD QUAND VIENT FIRSTLY
            db.doc(n).set( {'vend':false,'dispo':false},SetOptions(merge: true));
          }
          
        }
        else{
          debugPrint(" Ton batard ");
          for( var doc in value.docs ){
            var dat = doc.data() ;
            if(doc.id == nomGaz[0]){
              ecoutStock.setQteOryx6 = dat["quantite"] ;
              if(dat['vend']){
                ecoutStock.setVendOryx = true;
                ecoutStock.getListGazVendu.addAll(['Oryx6','Oryx12']);
              }
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Oryx6');
              }

            }else if(doc.id == "Oryx12"){
              ecoutStock.setQteOryx12 = dat['quantite'] ;
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Oryx12');
              }
            }else if(doc.id == "Total6"){
              ecoutStock.setQteTotal6 = dat["quantite"];
              if(dat['vend']){
                ecoutStock.setVendTotal = true;
                ecoutStock.getListGazVendu.addAll(['Total6','Total12']);
              }
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Total6');
              }

            }else if(doc.id == "Total12"){
              ecoutStock.setQteTotal12 = dat["quantite"];
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Total12');
              }

            }else if(doc.id == "Sodigaz6"){
              ecoutStock.setQteSodigaz6 = dat["quantite"];
              if(dat['vend']){
                ecoutStock.setVendSodigaz = true;
                ecoutStock.getListGazVendu.addAll(['Sodigaz6','Sodigaz12']);
              }
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Sodigaz6');
              }
            }else if(doc.id == nomGaz[5]){
              ecoutStock.setQteSodigaz12 = dat["quantite"];
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Sodigaz12');
              }

            }else if(doc.id == nomGaz[6]){
              ecoutStock.setQtePegaz6 = dat["quantite"];
              if(dat['vend']){
                ecoutStock.setVendPegaz = true;
                ecoutStock.getListGazVendu.addAll(['Pegaz6','Pegaz12']);
              }
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Pegaz6');
              }
            }else if(doc.id == nomGaz[7]){
              ecoutStock.setQtePegaz12 = dat["quantite"];
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Pegaz12');
              }
            }
          }
        }
      },onError: (e){ecoutStock.setNonRecupData=true;}).timeout(const Duration(seconds: 10));
    }
  }
  
  Future<void> updateGazVendu({required BuildContext context,required String gaz6,required String gaz12,required bool ch})async{
    final ec = Provider.of<ListenerBoutiq>(context,listen: false);
    final id = FirebaseAuth.instance.currentUser!.uid;
    final db = FirebaseFirestore.instance.collection('users').doc('$id');
    db.collection('gaz').doc(gaz6).update({'vend':ch});
    db.collection('gaz').doc(gaz12).update({'vend':ch});
    ch ?ec.getListGazVendu.addAll([gaz6,gaz12]) :ec.getListGazVendu.removeWhere( (e){return e == gaz6 || e == gaz12; });
  }

  Future<void> updateGazDispo({required String docGaz,required bool dispo})async{
    final id = FirebaseAuth.instance.currentUser!.uid;
    final db = FirebaseFirestore.instance.collection('users').doc('$id');
    db.collection('gaz').doc(docGaz).update({'dispo':dispo});
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