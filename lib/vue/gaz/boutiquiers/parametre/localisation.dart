import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Localisation extends StatefulWidget{
  Localisation({super.key});

  @override
  State<Localisation> createState() => _LocalisationState();
}

class _LocalisationState extends State<Localisation> {

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  Position? localisation_courant;


  //liste de marqueur
  Set<Marker> markeur={

  };

  static CameraPosition positionParDefaut = CameraPosition(
    target: LatLng(12.37936693446791,-1.5101656766943772),
    zoom: 14,
  );

  Future<void> prendreLocalisationCourant()async
  {
    // ERREUR QUAND LE USER 
    //                      REFUSE L'ACCES A SA POSITION 
    //                                                      A CORRIGER


    //revu a la ligne ::: 108 a 135 lors du click de luser

    localisation_courant = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> _moveCameraToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    if (localisation_courant != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(localisation_courant!.latitude, localisation_courant!.longitude),
          zoom: 17,
        ),
      ));

      setState(() {
        markeur.add(
            Marker(
                markerId: MarkerId("Position de l'utilisateur"),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                position: LatLng(localisation_courant!.latitude, localisation_courant!.longitude)
            )
        );
      });

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //prendreLocalisationCourant().then((value) => _moveCameraToCurrentLocation(),);
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
            title: Text("confirmation",style: TextStyle(fontFamily: "Poppins"),),
            content: Text("Voulez vous confirmer votre position et l'enregistrer ?",style: TextStyle(fontFamily: "Poppins"),),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text("Non")),

              TextButton(
                  onPressed: ()async {

                    showModalBottomSheet(context: context, builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
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
                                  markerId: MarkerId("Position du l'utilisateur"),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                                  position: LatLng(localisation_courant!.latitude, localisation_courant!.longitude)
                              )
                          );
                        });

                        _moveCameraToCurrentLocation();

                      }

                    Navigator.pop(context);
                    Navigator.pop(context);

                  }, child: Text("Oui Oui",style: TextStyle(fontFamily: "Poppins"),)
              )
            ],

          ),);
        },
        child:Icon(Icons.location_on)
      ),
    );
  }
}