import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';



class Suggest {
  
// METHODE PERMETTANT DE FAIRE UNE RECHERCHE DES 
//                                            VENDEURS QUI ONT LE GAZ DISPO
  Future<List<Map<String, dynamic>>> recupLocate({required String ville,required String gaz,required String poids})async{
    List<Map<String,dynamic>> listLocate = [];
    var loc = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
    );
    final db = FirebaseFirestore.instance;
    await db.collection('users').get(GetOptions(serverTimestampBehavior: ServerTimestampBehavior.estimate))
    .then((value)async {
      final docs = value.docs;
      for(var doc in docs){
        
        var dataSeller = doc.data();
        if(dataSeller['ville'] == ville && dataSeller['verify'] == true){ // VERIF VOIR SI LE BOUTIQUIER EST DANS LA VILLE DU USER ET A UN COMPTE VERIFIER AVANT DE CONTINUER LES SEARCH
          final dataGaz =await  FirebaseFirestore.instance.collection('users').doc(doc.id).collection('gaz').doc('$gaz$poids').get();
          if (dataGaz['dispo']){
            var dist = Geolocator.distanceBetween(// PERMET DE CALCULER LA DISTANCE SEPARANT LE USER DU BOUTIQUIER
              loc.latitude,
              loc.longitude,
              dataSeller['locate'].latitude,
              dataSeller['locate'].longitude).toInt()/1000;
            dataSeller.addAll({'dist':dist});
            listLocate.add( dataSeller);
          }
        }
      }
    });
// PERMET DE VERIFIER QUE LES DIFFERENTS 
//                                     CHAMPS DE RECHERCHES SONT SAISIS
    listLocate.sort( (a,b) => (a['dist'] as double).compareTo(b['dist'] as double)  );
    debugPrint('$listLocate /////');
    return listLocate;
  }

  bool checkSearchField({required String ville,required String nom,required String poids}){

    if(ville != '' && nom != '' && poids != '') return true;
    return false;
  }

// METHODE PERMETTANT DE FAIRE UNE RECHERCHE DES 
//                                            VENDEURS QUI N'ONT PAS LE GAZ DISPO MAIS QUI LE VENDENT
  Future<List<Map<String, dynamic>>> recupLocateVend({required String ville,required String gaz,required String poids})async{
    List<Map<String,dynamic>> listLocate = [];
    var loc = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
    );
    final db = FirebaseFirestore.instance;
    await db.collection('users').get(GetOptions(serverTimestampBehavior: ServerTimestampBehavior.estimate))
    .then((value)async {
      final docs = value.docs;
      for(var doc in docs){
        
        var dataSeller = doc.data();
        if(dataSeller['ville'] == ville && dataSeller['verify'] == true){ // VERIF VOIR SI LE BOUTIQUIER EST DANS LA VILLE DU USER ET A UN COMPTE VERIFIER AVANT DE CONTINUER LES SEARCH
          final dataGaz =await  FirebaseFirestore.instance.collection('users').doc(doc.id).collection('gaz').doc('$gaz$poids').get();
          if (dataGaz['vend']){
            var dist = Geolocator.distanceBetween( // PERMET DE CALCULER LA DISTANCE SEPARANT LE USER DU BOUTIQUIER
              loc.latitude,
              loc.longitude,
              dataSeller['locate'].latitude,
              dataSeller['locate'].longitude).toInt()/1000;
            dataSeller.addAll({'dist':dist});
            listLocate.add( dataSeller);
          }
        }
      }
    });
   
    listLocate.sort( (a,b) => (a['dist'] as double).compareTo(b['dist'] as double)  );
    debugPrint('$listLocate /////');
    return listLocate;
  }

}