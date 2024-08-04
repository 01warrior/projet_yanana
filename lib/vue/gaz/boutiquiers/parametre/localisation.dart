import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yanana/models/gaz/boutiquier_back.dart';
import 'package:yanana/vue/gaz/boutiquiers/listener.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Localisation extends StatefulWidget{
  const Localisation({super.key});

  @override
  State<Localisation> createState() => _LocalisationState();
}

class _LocalisationState extends State<Localisation> {

  
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  Position? localisationCourant;


  //liste de marqueur
  Set<Marker> markeur={

  };

  static CameraPosition positionParDefaut =const CameraPosition(
    target: LatLng(12.37936693446791,-1.5101656766943772),  // A REVOIR AFTA SI JE SUPPRESSE CES DATAS ¨POUR LET CEUX DANS INITSTATE
    zoom: 14,
  );

  Future<void> prendreLocalisationCourant()async
  {
    final ec = Provider.of<ListenerBoutiq>(context,listen: false);
    // ERREUR QUAND LE USER 
    //                      REFUSE L'ACCES A SA POSITION 
    //                                                      A CORRIGER


    //revu a la ligne ::: 108 a 135 lors du click de luser

    localisationCourant = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    ec.setUserLocate = GeoPoint(localisationCourant!.latitude,localisationCourant!.longitude);
  }

  Future<void> _moveCameraToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    if (localisationCourant != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(localisationCourant!.latitude, localisationCourant!.longitude),
          zoom: 17,
        ),
      ));

      setState(() {
        markeur.add(
            Marker(
                markerId:const MarkerId("Position de l'utilisateur"),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                position: LatLng(localisationCourant!.latitude, localisationCourant!.longitude)
            )
        );
      });

    }
  }
// MARQUER LE LIEU DU USER QUAND IL
//                           ARRIVE FIRSTLY HERE


  @override
  void initState() {
    super.initState();
    final ec = Provider.of<ListenerBoutiq>(context,listen: false);
    //prendreLocalisationCourant().then((value) => _moveCameraToCurrentLocation(),);
    positionParDefaut = CameraPosition(
      target: LatLng(ec.getUserLocate.latitude,ec.getUserLocate.longitude),
      zoom: 19,
    );
    
  }

  @override
  Widget build(BuildContext context){
    
    return Scaffold(

      appBar: AppBar(title:const Text('Localisation'),),

      body:GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition:positionParDefaut,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

        markers:markeur,

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
            title:const Text("confirmation",style: TextStyle(fontFamily: "Poppins"),),
            content:const Text("Voulez vous changer votre position et l'enregistrer ?",style: TextStyle(fontFamily: "Poppins"),),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child:const Text("Non")),

              TextButton(
                  onPressed: ()async {

                    showModalBottomSheet(context: context, builder: (context) {
                      return const Padding(
                        padding:  EdgeInsets.all(15.0),
                        child: CircularProgressIndicator(color: Colors.orange,),
                      );
                    },);

                    //je redemande la permission lors du clic au cas ou luser avait refusé au debut
                    LocationPermission permission = await Geolocator.checkPermission();

                    if (permission == LocationPermission.denied)
                    {
                      permission = await Geolocator.requestPermission();
                    }
                    //si cest accordé
                    else
                      {
                        //je reprend la localisation et je met a jour la position du camera
                        await prendreLocalisationCourant();

                        //j'enleve les marqueur qui etait la (sa position ancienne)
                        markeur.removeAll(markeur);

                        setState(() {
                          markeur.add(
                              Marker(
                                  markerId:const MarkerId("Position du l'utilisateur"),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                                  position: LatLng(localisationCourant!.latitude, localisationCourant!.longitude)
                              )
                          );
                        });

                        _moveCameraToCurrentLocation();

                        //METTRE A JOUR LES CHANGEMENTS SUR LA BD
                        BoutiquierBack().updateLocate(context:context,newLocate: GeoPoint(localisationCourant!.latitude,localisationCourant!.longitude));

                      }

                    Navigator.pop(context);
                    Navigator.pop(context);

                  }, child:const Text("Oui Oui",style: TextStyle(fontFamily: "Poppins"),)
              )
            ],

          ),);
        },
        child:const Icon(Icons.location_on)
      ),
    );
  }
}