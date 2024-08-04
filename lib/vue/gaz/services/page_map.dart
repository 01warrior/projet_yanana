import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navigation_with_mapbox/navigation_with_mapbox.dart';
import 'package:yanana/vue/gaz/services/page_recherche_gaz.dart';


class WidgetMap extends StatefulWidget {

  Position? localisationCourant;
  final GeoPoint boutiqueClique;

  WidgetMap(
      {super.key,
      required this.localisationCourant,
      required this.boutiqueClique
      }
      );

  @override
  State<WidgetMap> createState() => _WidgetMapState();
}

//class widget
class _WidgetMapState extends State<WidgetMap> {
// create an instance of the plugin
  final _navigationWithMapboxPlugin = NavigationWithMapbox();

  Future commencerNavigation() async {

    await _navigationWithMapboxPlugin.startNavigation(
        // debut de navigation
        origin: WayPoint(latitude: widget.localisationCourant!.latitude, longitude: widget.localisationCourant!.longitude),
        // destination
        destination: WayPoint(latitude: widget.boutiqueClique.latitude, longitude:  widget.boutiqueClique.longitude),
        // choisir destination long appui
        setDestinationWithLongTap: false,
        simulateRoute: false,
        // voir route alternative
        alternativeRoute: true,
        // style
        // default: streets ,autre : dark, light, traffic_day, traffic_night, satellite, satellite_streets, outdoors
        style: 'outdoors',
        language: 'fr',
        // par defaut: driving, autre: walking, cycling
        profile: 'driving',
        //voix
        // default: metric
        voiceUnits: 'imperial',
        // message de debut
        //msg: '${widget.boutiqueClique["lieu"]}'

    );

  }

  Future tenirAjourPositionCheckDistance()async
  {
    var distance;

    //prendre la nouvelle position
    widget.localisationCourant = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    distance=Geolocator.distanceBetween(
        widget.localisationCourant!.latitude,
        widget.localisationCourant!.longitude,
        widget.boutiqueClique.latitude,
        widget.boutiqueClique.longitude).toInt()/1000;

    debugPrint(distance);

    if(distance<0.15)
    {
     /* Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Page_service_gaz();
        },));*/
      showModalBottomSheet(context: context, builder: (context) {
        return SizedBox(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Succes"),
                  Icon(Icons.ac_unit,size: 40,color: Colors.green,)
                ],
              ),

              const SizedBox(
                height: 200,
                child: Column(
                  children: [
                    Text("Vous etes arrivé a destination etes vous satisfait ?")
                  ],
                ),
              ),

              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child:const Text("Oui bien sur")),

              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child:const Text("Pas vraiment"))

            ],
          ),
        );
      },);

    }

    else
      {return 0;}

  }

  //lors de linit on commence a checker la position et distance au cour de la navigation
  @override
  void initState() {
    super.initState();
    
///////////////////////////////////////// REVOIR CA CAR PROVOQUE DES BUGS ON APP/////////////////////////////////////
///
    /*Timer.periodic(Duration(seconds: 10), (Timer compteur) {
      TenirAjourPositionCheckDistance();
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:const Text("Direction",style: TextStyle(fontFamily: "Poppins"),),
        ),
        body: Center(
          child: Column(
            children: [
              Flexible(
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(alignment: Alignment.center,
                              children:[

                                const SpinKitDoubleBounce(
                                  color: Colors.orange,
                                  size: 210.0,
                                ),SizedBox(height:150 ,
                                  width: 150,
                                  child:

                                  ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:MaterialStatePropertyAll(Colors.green.shade400) ,
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100)
                                          ))
                                  ),
                                    onPressed:() async {

                                    LocationPermission permission = await Geolocator.checkPermission();

                                    if (permission == LocationPermission.denied)
                                    {
                                      permission = await Geolocator.requestPermission();
                                    }
                                    else
                                    {
                                      afficherMap();

                                    }

                                    },
                                    child: const Text('Demarrer',style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Poppins"),),
                                  ),)
                              ]
                            ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),

        ));
  }

  Future<Widget> afficherMap()async
  {
    return await commencerNavigation();
  }

}
