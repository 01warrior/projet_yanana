import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navigation_with_mapbox/navigation_with_mapbox.dart';


class WidgetMap extends StatefulWidget {
  final Position? localisation_courant;
  final Map boutiqueClique;

  WidgetMap(
      {super.key,
      required this.localisation_courant,
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
    // we start the navigation
    await _navigationWithMapboxPlugin.startNavigation(
        // debut de navigation
        origin: WayPoint(latitude: widget.localisation_courant!.latitude, longitude: widget.localisation_courant!.longitude),
        // destination
        destination: WayPoint(latitude: widget.boutiqueClique["latitude"], longitude:  widget.boutiqueClique["longitude"]),
        // choisir destination long appui
        setDestinationWithLongTap: false,
        simulateRoute: false,
        // voir route alternative
        alternativeRoute: true,
        // style
        // default: streets ,autre : dark, light, traffic_day, traffic_night, satellite, satellite_streets, outdoors
        style: 'satellite_streets',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Direction",style: TextStyle(fontFamily: "Poppins"),),
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
                          SizedBox(height:160 ,
                            width: 160,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:MaterialStatePropertyAll(Colors.green.shade400) ,
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)
                                ))
                              ),
                              onPressed:() async {
                                      commencerNavigation();
                                    },
                              child: const Text('Demarrer',style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Poppins"),),
                            ),
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

}
