import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yanana/vue/gaz/services/page_map.dart';


class Page_service_gaz extends StatefulWidget {
  const Page_service_gaz({super.key});

  @override
  State<Page_service_gaz> createState() => _Page_service_gazState();
}

class _Page_service_gazState extends State<Page_service_gaz> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lieux de recharge",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
        backgroundColor: Colors.black87,
      ),


      body: Column(

        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            color: Colors.black87,
            child: DropdownMenu(
              width: 300,
              selectedTrailingIcon:Icon(Icons.arrow_drop_up,color: Colors.blue,size: 25,),
              textStyle: TextStyle(fontSize:20),
              hintText: "Type gaz : Ex Oryx",
              menuStyle:MenuStyle(
                shape:MaterialStatePropertyAll(
                    RoundedRectangleBorder(borderRadius:BorderRadius.circular(30))
                ),
                shadowColor:MaterialStatePropertyAll(Colors.black87 ),
              ),

              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              ),

              dropdownMenuEntries:[
                DropdownMenuEntry(value: "Total", label:"Total",),
                DropdownMenuEntry(value: "Oryx", label:"Oryx"),
                DropdownMenuEntry(value: "Pegaz", label:"Pegaz"),
                DropdownMenuEntry(value: "Sodigaz", label:"Sodigaz"),
              ],
              onSelected: (value) {

              },
            ),
          ),

          ListLieuxProche()

        ],
      ),

    );

  }
}




class ListLieuxProche extends StatefulWidget {
  const ListLieuxProche({super.key});

  @override
  State<ListLieuxProche> createState() => _ListLieuxProcheState();
}

class _ListLieuxProcheState extends State<ListLieuxProche> {

  Position? localisation_courant;

  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();

    calculerDistance();

  }*/

  List<Map> listLieux = [
    {"lieu": "boutique 1",
      "latitude":12.402716096877667,
      "longitude":-1.5282797965314217
    },

    {"lieu": "boutique 2",
      "latitude":12.36566,
      "longitude":-1.53388
    },

    {"lieu": "boutique 3",
      "latitude":12.25566,
      "longitude":-1.64388
    },

    {"lieu": "boutique 4",
      "latitude":12.40566,
      "longitude": -1.59388
    },

    {"lieu": "boutique 5",
      "latitude":12.50566,
      "longitude":-1.73388
    },

    {"lieu": "boutique 6",
      "latitude":12.4336217,
      "longitude":-1.5326067
    },

    {"lieu": "boutique 7",
      "latitude":12.4335583,
      "longitude":-1.5125980
    },

  ];

  //je reinitialise la liste de distance pour pas quil ajoute les nouvelle valeur au encienne
  var listDistance = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: calculerDistance(),
        builder: (context, snapshot) {

          if(snapshot.hasData)
          {

            return ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount:listLieux.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return WidgetMap(localisation_courant: localisation_courant,boutiqueClique: listLieux[index],);
                      },));
                  },

                  child: Card(
                    child: ListTile(contentPadding: EdgeInsets.all(10),
                      leading: Icon(Icons.maps_home_work,size: 35,),
                      title: Text(listLieux[index]["lieu"]),
                      trailing:listDistance[index]<6? Text("${listDistance[index]} Km",
                        style: TextStyle(color:Colors.green,fontSize: 18, fontFamily: "Poppins"),)
                          :listDistance[index]<10?
                      Text("${listDistance[index]} Km",
                        style: TextStyle(color:Colors.orange,fontSize: 18, fontFamily: "Poppins"),)
                          :
                      Text("${listDistance[index]} Km",
                        style: TextStyle(color:Colors.red,fontSize: 18, fontFamily: "Poppins"),),
                    ),
                  ),
                );
              },);

          }

          else if(snapshot.hasError)
          {
            return Text("Erreur lors des calcul veillez relancer");
          }
          else if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator());
          }
          else
            return Text("Aucune donné");
        },
      ),
    );
  }


  Future calculerDistance()async
  {

    //je Verifie letat de la permission
    LocationPermission permission = await Geolocator.checkPermission();


    if (permission == LocationPermission.denied) {

      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Veillez activer votre localisation"),
          actions: [
            TextButton(onPressed: ()async {
              Navigator.of(context).pop();
              //je redemande la permission
              permission = await Geolocator.requestPermission();
            }, child: Text("Ok")
            )
          ],
        );
      },);

      // L'utilisateur n'a pas encore accordé la permission de localisation.
      // afficher un message ou demander à nouveau la permission.
    }

    else if (permission == LocationPermission.deniedForever) {
      // L'utilisateur a refusé la permission de localisation de façon permanente.
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Veillez accorder l'autaurisation d'activer votre localisation sans quoi lapplication ne vas pas fonctionner"),
          actions: [
            TextButton(onPressed: ()async {
              Navigator.of(context).pop();
              //et on  redemande encore
              permission = await Geolocator.requestPermission();
            }, child: Text("Ok")
            )
          ],
        );
      },);
    }

    else {
      // L'utilisateur a déjà accordé la permission de localisation.
      // maintenant obtenir la localisation actuelle.
      localisation_courant = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      //print('Latitude: ${localisation_courant!.latitude}, Longitude: ${localisation_courant!.longitude}');


      //jai créer une liste de distance pour eviter de calculer manuelement les distance je calcule avec une boucle
      // for tant que je natteint pas la longueur de la liste des lieu

      //les distance sont en mettre donc conversion en int et division par 1000
      for (int i = 0; i < listLieux.length; i++) {
        listDistance.add(await Geolocator.distanceBetween(
            localisation_courant!.latitude,
            localisation_courant!.longitude,
            listLieux[i]["latitude"],
            listLieux[i]["longitude"]).toInt()/1000
        );

        //print("la liste des distance :$listDistance");

      }

      return listDistance;

    }

  }

}
