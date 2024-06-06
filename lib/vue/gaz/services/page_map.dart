import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navigation_with_mapbox/navigation_with_mapbox.dart';
import 'package:yanana/vue/gaz/services/page_service_gaz.dart';


class WidgetMap extends StatefulWidget {

  Position? localisation_courant;
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

  Future TenirAjourPositionCheckDistance()async
  {
    var distance;

    //prendre la nouvelle position
    widget.localisation_courant = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    distance=Geolocator.distanceBetween(
        widget.localisation_courant!.latitude,
        widget.localisation_courant!.longitude,
        widget.boutiqueClique["latitude"],
        widget.boutiqueClique["longitude"]).toInt()/1000;

    print(distance);

    if(distance<0.15)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Page_service_gaz();
        },));


      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Succes"),
              Icon(Icons.ac_unit,size: 40,color: Colors.green,)
            ],
          ),
          content: Container(
            height: 200,
            child: Column(
              children: [
                Text("Vous etes arrivé a destination etes vous satisfait ?")
              ],
            ),
          ),

          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: () {

                }, child: Text("Oui bien sur")),

                TextButton(onPressed: () {

                }, child: Text("Pas vraiment"))

              ],
            )
          ],
        );
      },);
    }

    else
      return 0;

  }

  //lors de linit on commence a checker la position et distance au cour de la navigation
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer.periodic(Duration(seconds: 10), (Timer compteur) {
      TenirAjourPositionCheckDistance();
    });
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
                          Stack(alignment: Alignment.center,
                              children:[

                                SpinKitDoubleBounce(
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
