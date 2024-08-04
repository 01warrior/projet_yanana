import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yanana/vue/gaz/boutiquiers/listener.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

class  BoutiquierBack {

  
  
  var nomGaz =["Oryx6","Oryx12","Total6","Total12","Sodigaz6","Sodigaz12","Pegaz6","Pegaz12",'Shell6','Shell12'];

  recupData(BuildContext context)async{
    final ecoutStock = Provider.of<ListenerBoutiq>(context,listen: false);
    String id = FirebaseAuth.instance.currentUser!.uid;
    print(id);
    if(ecoutStock.getNonRecupData){
      context.mounted ? await findUserCity(context:context,locate:  ecoutStock.getUserLocate ) : null;// META JOUR LA VAR VILLE
      var db = FirebaseFirestore.instance.collection(ecoutStock.getUserVille).doc(id).collection('gaz');
      await db.get()
      .then((value)async {
        
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
              if(dat['vend']){
                ecoutStock.setVendOryx = true;
                ecoutStock.getListGazVendu.addAll(['Oryx6','Oryx12']);
              }
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Oryx6');
              }

            }else if(doc.id == "Oryx12"){
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Oryx12');
              }
            }else if(doc.id == "Total6"){
              if(dat['vend']){
                ecoutStock.setVendTotal = true;
                ecoutStock.getListGazVendu.addAll(['Total6','Total12']);
              }
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Total6');
              }

            }else if(doc.id == "Total12"){
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Total12');
              }

            }else if(doc.id == "Sodigaz6"){
              if(dat['vend']){
                ecoutStock.setVendSodigaz = true;
                ecoutStock.getListGazVendu.addAll(['Sodigaz6','Sodigaz12']);
              }
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Sodigaz6');
              }
            }else if(doc.id == 'Sodigaz12'){
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Sodigaz12');
              }

            }else if(doc.id == 'Pegaz6'){
              if(dat['vend']){
                ecoutStock.setVendPegaz = true;
                ecoutStock.getListGazVendu.addAll(['Pegaz6','Pegaz12']);
              }
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Pegaz6');
              }
            }else if(doc.id == 'Pegaz12'){
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Pegaz12');
              }
            }else if(doc.id == 'Shell6'){
              if(dat['vend']){
                ecoutStock.setVendShell = true;
                ecoutStock.getListGazVendu.addAll(['Shell6','Shell12']);
              }
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Shell6');
              }
            }else if(doc.id == 'Shell12'){
              if(dat['dispo']){
                ecoutStock.getListGazDispo.add('Shell12');
              }
            }
          }

        }
        await FirebaseFirestore.instance.collection(ecoutStock.getUserVille).doc(id).get().then(
          (value){
            final datas = value.data()!;
            ecoutStock.setVerifyCompte = datas['verify'];
            ecoutStock.setUserLocate = datas['locate'];
            ecoutStock.setNom = datas['nom'];
            ecoutStock.setEmail = datas['email'];
            ecoutStock.setTelephone = datas['telephone'];

          },onError: (e) => null );
        
        ecoutStock.setNonRecupData=false;
      },onError: (e){ecoutStock.setNonRecupData=true;});
    }
    
  }
  Future<void> findUserCity({required BuildContext context,required GeoPoint locate})async{
    final ec = Provider.of<ListenerBoutiq>(context,listen: false);
    List<Placemark> placemarks = await placemarkFromCoordinates(locate.latitude, locate.longitude)
    .then((value) => value,onError: (e){ });
    debugPrint('${placemarks[1].toString()}   LENGTH  :${ placemarks.length}');
    placemarks.isNotEmpty && placemarks[0].locality != null ? ec.setUserVille = placemarks[0].locality! : null;
        //List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
    //placemarks[0].
  }

  Future<void> updateProfil({required BuildContext context,required String nom,required String tel})async{
    // J'ARRIVE ATTENDS
    final ec = Provider.of<ListenerBoutiq>(context,listen: false);
    String id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection(ec.getUserVille).doc(id).update({'nom':nom,'telephone':tel}).
    then((value) {
      ec.setNom = nom;
      ec.setTelephone = tel;
    },onError: (e){ });
  }

  fillChampsProfil({required BuildContext context}){
    final ec = Provider.of<ListenerBoutiq>(context,listen: false);
    ec.getNomC.text = ec.getNom;
    ec.getEmailC.text = ec.getEmail;
    ec.getTelephoneC.text = ec.getTelephone;
  }

  Future<void> recupVille({required BuildContext context})async{
    final ec = Provider.of<ListenerBoutiq>(context,listen: false);
    await FirebaseFirestore.instance.collection('ville').get()
    .then((value) {
      final docs = value.docs;
      for(var doc in docs ){
        var data = doc.data();
        ec.getListVille.add(data['nom']);
      }
    });
  }

  Future<void> updateLocate({required BuildContext context,required GeoPoint newLocate})async {
    final ec = Provider.of<ListenerBoutiq>(context,listen: false);
    String id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection(ec.getUserVille).doc(id).update({'locate':newLocate})
     .then((value) {
        // RIEN DAB
     });
  }
  
  Future<void> updateGazVendu({required BuildContext context,required String gaz6,required String gaz12,required bool ch})async{
    final ec = Provider.of<ListenerBoutiq>(context,listen: false);
    final id = FirebaseAuth.instance.currentUser!.uid;
    final db = FirebaseFirestore.instance.collection(ec.getUserVille).doc('$id');

    ch ? null : db.collection('gaz').doc(gaz6).update({'dispo':ch  });
    ch ? null : db.collection('gaz').doc(gaz12).update({'dispo':ch  });

    db.collection('gaz').doc(gaz6).update({'vend':ch,});//met à jour l'etat de disponibilité et de vente d'un gaz( 6kg )
    db.collection('gaz').doc(gaz12).update({'vend':ch,});//met à jour l'etat de disponibilité et de vente d'un gaz( 12kg )

    ch ?ec.getListGazVendu.addAll([gaz6,gaz12]) :ec.getListGazVendu.removeWhere( (e){return e == gaz6 || e == gaz12; });//permet de supp de lal iste de gaz vendu les gaz que le vendeur a signalé comme non vendu
    ch ? null : ec.getListGazDispo.removeWhere((element) { return element == gaz6 || element == gaz12 ;}) ;//permet de supp de laliste de gaz dispo les gaz que le vendeur a signalé comme non vendu
  }

  Future<void> updateGazDispo({required BuildContext context,required String docGaz,required bool dispo})async{
    final ec = Provider.of<ListenerBoutiq>(context,listen: false);
    final id = FirebaseAuth.instance.currentUser!.uid;
    final db = FirebaseFirestore.instance.collection(ec.getUserVille).doc('$id');
    db.collection('gaz').doc(docGaz).update({'dispo':dispo});
  }


  Future<bool> ajoutStock({required BuildContext context, required String nomGaz,required int nombre})async{
    final ec = Provider.of<ListenerBoutiq>(context,listen: false);
    String id = FirebaseAuth.instance.currentUser!.uid;
    bool upd=true;
    await FirebaseFirestore.instance.collection(ec.getUserVille).doc(id)
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