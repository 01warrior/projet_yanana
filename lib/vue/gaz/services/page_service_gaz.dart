import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:yanana/vue/gaz/services/page_map.dart';
import 'package:yanana/models/gaz/suggest.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../widget/animation_fade.dart';

class Page_service_gaz extends StatefulWidget {
  const Page_service_gaz({super.key});

  @override
  State<Page_service_gaz> createState() => _Page_service_gazState();
}

class _Page_service_gazState extends State<Page_service_gaz> {
  Position? localisation_courant;
  String _gaz = '';
  String _ville = '';
  String _poids = '';
  String _oldGaz = '';
  String _oldVille = '';
  String _oldPoids = '';
  bool _switchV = false;
  bool _search = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      /*appBar: AppBar(
        //leading:Text('oo'),
        automaticallyImplyLeading:false,
        leadingWidth: 15.0,
        centerTitle: true,
        title: DropdownMenu(
                  onSelected: (s){
                    s !=null ? setState((){
                      if(_oldVille != s){
                        _search = false;
                        _switchV = false;
                        _oldVille = s;
                      }
                      _ville = s ;}) : null;
                  },
                  width: MediaQuery.of(context).size.width/1.2 ,
                  hintText: "Ex Ouagadougou",
                  selectedTrailingIcon:const Icon(Icons.arrow_drop_up,color: Colors.blue,size: 25,),
                  inputDecorationTheme:const InputDecorationTheme(
                    contentPadding:EdgeInsets.only(left:8.0,right:8.0,top:0.0,bottom: 0.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  menuStyle:MenuStyle(
                    shape:MaterialStatePropertyAll(
                        RoundedRectangleBorder(borderRadius:BorderRadius.circular(30))
                    ),
                    shadowColor:const MaterialStatePropertyAll(Colors.black87 ),
                  ),
                  dropdownMenuEntries:const[//Data doit provenir de la database
                    DropdownMenuEntry(value: 'Ouagadougou', label: 'Ouagadougou'),
                    DropdownMenuEntry(value: 'Bobo Dioulasso', label: 'Bobo Dioulasso')
                  ]
                ),
        backgroundColor: Colors.black12,
      ),
*/

      body: Column(

        children: [

          Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: Colors.black12,
            padding: EdgeInsets.only(top: 60),
            child: FadeInWidget(
              direction: "top",
              child: DropdownMenu(
                  onSelected: (s){
                    s !=null ? setState((){
                      if(_oldVille != s){
                        _search = false;
                        _switchV = false;
                        _oldVille = s;
                      }
                      _ville = s ;}) : null;
                  },
                  width: MediaQuery.of(context).size.width/1.1 ,
                  hintText: "Ex Ouagadougou",
                  selectedTrailingIcon:const Icon(Icons.arrow_drop_up,color: Colors.blue,size: 25,),
                  inputDecorationTheme:const InputDecorationTheme(
                    contentPadding:EdgeInsets.only(left:8.0,right:8.0,top:0.0,bottom: 0.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  menuStyle:MenuStyle(
                    shape:MaterialStatePropertyAll(
                        RoundedRectangleBorder(borderRadius:BorderRadius.circular(30))
                    ),
                    shadowColor:const MaterialStatePropertyAll(Colors.black87 ),
                  ),
                  dropdownMenuEntries:const[//Data doit provenir de la database
                    DropdownMenuEntry(value: 'Ouagadougou', label: 'Ouagadougou'),
                    DropdownMenuEntry(value: 'Bobo Dioulasso', label: 'Bobo Dioulasso')
                  ]
              ),
            ),
          ),

          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding:const EdgeInsets.all(15),
            color: Colors.black12,
            child: Row(
              children: [
                FadeInWidget(
                  direction: "left",
                  child: DropdownMenu(
                    onSelected: (s){
                      s !=null ? setState((){
                        if(_oldGaz != s){
                          _search = false;
                          _switchV = false;
                          _oldGaz = s;
                        }
                        _gaz = s ;}) : null;
                    },
                    width: MediaQuery.of(context).size.width/1.8 ,
                    selectedTrailingIcon:const Icon(Icons.arrow_drop_up,color: Colors.blue,size: 25,),
                    //textStyle:const TextStyle(fontSize:20),
                    hintText: "Ex Oryx",
                    menuStyle:MenuStyle(
                      shape:MaterialStatePropertyAll(
                          RoundedRectangleBorder(borderRadius:BorderRadius.circular(30))
                      ),
                      shadowColor:const MaterialStatePropertyAll(Colors.black87 ),
                    ),

                    inputDecorationTheme:const InputDecorationTheme(
                      contentPadding:EdgeInsets.only(left:8.0,right:8.0,top:0.0,bottom: 0.0),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),

                    dropdownMenuEntries:const[
                      DropdownMenuEntry(value: "Total", label:"Total",),
                      DropdownMenuEntry(value: "Oryx", label:"Oryx"),
                      DropdownMenuEntry(value: "Pegaz", label:"Pegaz"),
                      DropdownMenuEntry(value: "Sodigaz", label:"Sodigaz"),
                    ],

                  ),
                ),
                const Spacer(),
                FadeInWidget(
                  direction: "right",
                  child: DropdownMenu(
                    onSelected: (s){
                      s !=null ? setState((){
                        if(_oldPoids != s){
                          _search = false;
                          _switchV = false;
                          _oldPoids = s;
                        }
                        _poids = s ;}) : null;
                    },
                    width: MediaQuery.of(context).size.width/3 ,
                    hintText: "Ex 6kg",
                    selectedTrailingIcon:const Icon(Icons.arrow_drop_up,color: Colors.blue,size: 25,),
                    inputDecorationTheme:const InputDecorationTheme(
                      contentPadding:EdgeInsets.only(left:8.0,right:8.0,top:0.0,bottom: 0.0),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    menuStyle:MenuStyle(
                      shape:MaterialStatePropertyAll(
                          RoundedRectangleBorder(borderRadius:BorderRadius.circular(30))
                      ),
                      shadowColor:const MaterialStatePropertyAll(Colors.black87 ),
                    ),
                    dropdownMenuEntries:const[
                      DropdownMenuEntry(value: '6', label: '6kg'),
                      DropdownMenuEntry(value: '12', label: '12kg')
                    ]
                  ),
                )
              ],
            ),
          ),
          if(Suggest().checkSearchField(ville: _ville, nom:_gaz, poids: _poids)  && !_search)

            Padding(
              padding: const EdgeInsets.only(top: 170.0),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInWidget(
                          direction:"bottom1",
                          child: Stack(alignment: Alignment.center,
                              children:[

                                SpinKitDoubleBounce(
                                  color: Colors.orange,
                                  size: 220.0,
                                ),SizedBox(height:160 ,
                                  width: 160,
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
                                      setState((){_search = true;});
                                    },
                                    child: const Text('Rechercher ',style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "Poppins"),),
                                  ),)
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),


            /*Padding(
              padding: const EdgeInsets.only(top:160.0),
              child:
              ElevatedButton(
                onPressed: (){
                  setState((){_search = true;});
                },
                child:const Text('Lancez la recherche')),
            ),*/

          //ListLieuxProche()
          if(!Suggest().checkSearchField(ville: _ville, nom:_gaz, poids: _poids ))

            Center(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    LottieBuilder.asset("assets/images/write.json",),
                    DefaultTextStyle(
                        style: const TextStyle(
                          fontFamily: "Poppins",
                            fontSize: 18.0,
                            color:Colors.black87,
                        ), child: AnimatedTextKit(
                      pause:Duration(seconds: 4) ,
                        totalRepeatCount: 8,
                        animatedTexts: [
                          TypewriterAnimatedText(
                              speed: Duration(milliseconds:60),
                              'Veuillez renseigner toutes les données de recherche la haut',
                            textAlign: TextAlign.center,
                          ),
                        ],
                        isRepeatingAnimation: true,

                        onTap: () {
                          print("Tap Event");
                          },
                      ),),
                  ],
                ),
              ),
            ),


          /*const Padding(
            padding: EdgeInsets.only(top:160.0),
            child: Text(' Renseigner toutes les données de recherche'),
          ),*/

          if(Suggest().checkSearchField(ville: _ville, nom:_gaz, poids: _poids ) && _search)
          Expanded(
            child: FutureBuilder(
              future:_switchV ? Suggest().recupLocateVend(ville: _ville, gaz: _gaz, poids: _poids)   : Suggest().recupLocate(ville: _ville, gaz: _gaz, poids: _poids)  ,  //calculerDistance(),
              builder: (context, snapshot) {
                var datas = snapshot.data;
                if(snapshot.hasData)
                {
                  if(datas!.isNotEmpty){
                    return FadeInWidget(
                      direction:"top",
                      child: ListView.builder(
                        padding:const EdgeInsets.all(15),
                        itemCount:datas.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: ()async {

                              LocationPermission permission = await Geolocator.checkPermission();
                              if (permission == LocationPermission.denied)
                              {
                                permission = await Geolocator.requestPermission();
                              }
                              else
                              {
                                localisation_courant = await Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high,
                                );
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return WidgetMap(localisation_courant: localisation_courant,boutiqueClique: datas[index]['locate'],);
                                  },));
                              }

                            },

                            child: Card(
                              surfaceTintColor: Colors.white,
                              child: ListTile(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                tileColor: Colors.black12,
                                contentPadding:const EdgeInsets.all(10),
                                leading:const Icon(Icons.maps_home_work,size: 35,),
                                title: Text(datas[index]["nom"]),
                                trailing:datas[index]['dist']<6? Text("${datas[index]['dist']} Km",
                                  style:const TextStyle(color:Colors.green,fontSize: 18, fontFamily: "Poppins"),)
                                    :datas[index]['dist']<10?
                                Text("${datas[index]['dist']} Km",
                                  style:const TextStyle(color: Color.fromARGB(255, 2, 1, 1),fontSize: 18, fontFamily: "Poppins"),)
                                    :
                                Text("${datas[index]['dist']} Km",
                                  style:const TextStyle(color:Colors.red,fontSize: 18, fontFamily: "Poppins"),),
                              ),
                            ),
                          );
                        },),
                    );
                    }
                    else {

                    /*ElegantNotification.info(
                      notificationMargin:60,
                      title:  Text("Oups"),
                      description:  Text("Pas de resultat", style: TextStyle(color: Colors.black)),
                      onDismiss: () {

                      },
                      animationDuration:Duration(seconds: 4),
                    ).show(context);*/

                      return  Padding(
                        padding: const EdgeInsets.only(top:20.0),
                        child: Column(
                          children:[
                            _switchV ? const SizedBox()
                            :AlertDialog(
                              title:Text("Disponibilité pas confirmé",style: TextStyle(fontFamily: "Poppins"),),
                              content: Column(
                                children: [
                                  Image.asset("assets/images/empty.png",width:150),
                                  Text("Il ya de grande chance que le produit que vous recherchez soit indisponible, néamoins vous pouvez voir les lieux de vente proches de chez vous. Nous ne garantissons pas dans ce cas la disponibilté du produit.",style: TextStyle(fontFamily: "Poppins"),),
                                ],
                              ),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.pop(context);
                                }, child: Text("Non merci",style: TextStyle(fontFamily: "Poppins"),)),

                                TextButton(onPressed: ()
                                {
                                  setState((){
                                    _switchV = _switchV ? false : true;
                                  });
                                }, child: Text("Oui voir",style: TextStyle(fontFamily: "Poppins"),)
                                ),

                                /*
                                ElevatedButton(
                                    onPressed: (){
                                      setState((){
                                        _switchV = _switchV ? false : true;
                                      });
                                    },
                                    child:const Text('Voir lieux de ventes'))*/
                              ],backgroundColor: Colors.black12,
                            ),
                          ]
                        ),
                      );
                    }

                }

                else if(snapshot.hasError)
                {
                  ElegantNotification.error(
                    notificationMargin:60,
                    title:  Text("Oups"),
                    description:  Text("Une erreur s'est produite", style: TextStyle(color: Colors.black)),
                    onDismiss: () {

                    },
                    animationDuration:Duration(seconds: 4),
                  ).show(context);

                  return const Text("Une Erreur s'est produite");
                }
                else if(snapshot.connectionState==ConnectionState.waiting)
                {
                  return const SpinKitWaveSpinner(
                    color: Colors.orange,
                    size: 80.0,
                  );
                }
                else
                  {return const Text("Aucune donné");}
              },
            ),
          )

        ],
      ),

    );

  }
}


/*

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

  }

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
  var listDistance = [];*/

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: Suggest().recupLocate(ville: 'Ouagadougou', gaz: 'Oryx', poids: '6')  ,  //calculerDistance(),
        builder: (context, snapshot) {
          var datas = snapshot.data;
          if(snapshot.hasData)
          {

            return ListView.builder(
              padding:const EdgeInsets.all(15),
              itemCount:datas!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: ()async {

                    LocationPermission permission = await Geolocator.checkPermission();
                    if (permission == LocationPermission.denied)
                    {
                      permission = await Geolocator.requestPermission();
                    }
                    else
                    {
                      localisation_courant = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high,
                      );
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return WidgetMap(localisation_courant: localisation_courant,boutiqueClique: datas[index]['locate'],);
                        },));
                    }

                  },

                  child: Card(
                    surfaceTintColor: Colors.white,
                    child: ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      tileColor: Colors.black12,
                      contentPadding: EdgeInsets.all(10),
                      leading: Icon(Icons.maps_home_work,size: 35,),
                      title: Text(datas[index]["nom"]),
                      trailing:datas[index]['dist']<6? Text("${datas[index]['dist']} Km",
                        style: TextStyle(color:Colors.green,fontSize: 18, fontFamily: "Poppins"),)
                          :datas[index]['dist']<10?
                      Text("${datas[index]['dist']} Km",
                        style: TextStyle(color:const Color.fromARGB(255, 2, 1, 1),fontSize: 18, fontFamily: "Poppins"),)
                          :
                      Text("${datas[index]['dist']} Km",
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
            return SpinKitWaveSpinner(
              color: Colors.orange,
              size: 80.0,
            );
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
          title: Text("Veuillez activer votre localisation"),
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

    }

    // L'utilisateur n'a pas encore accordé la permission de localisation.
    // afficher un message ou demander à nouveau la permission.

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
      },
      );
      Navigator.of(context).pop();
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
      /*for (int i = 0; i < listLieux.length; i++) {
        listDistance.add(await Geolocator.distanceBetween(
            localisation_courant!.latitude,
            localisation_courant!.longitude,
            listLieux[i]["latitude"],
            listLieux[i]["longitude"]).toInt()/1000
        );

        //print("la liste des distance :$listDistance");

      }

      return listDistance;*/

    }

  }

}
*/