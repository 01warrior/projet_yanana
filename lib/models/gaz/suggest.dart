import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';



class Suggest {
  
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
        if(dataSeller['ville'] == ville && dataSeller['verify'] == true){
          final dataGaz =await  FirebaseFirestore.instance.collection('users').doc(doc.id).collection('gaz').doc('$gaz$poids').get();
          if (dataGaz['dispo']){
            var dist = Geolocator.distanceBetween(
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

  bool checkSearchField({required String ville,required String nom,required String poids}){

    if(ville != '' && nom != '' && poids != '') return true;
    return false;
  }


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
        if(dataSeller['ville'] == ville && dataSeller['verify'] == true){
          final dataGaz =await  FirebaseFirestore.instance.collection('users').doc(doc.id).collection('gaz').doc('$gaz$poids').get();
          if (dataGaz['vend']){
            var dist = Geolocator.distanceBetween(
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