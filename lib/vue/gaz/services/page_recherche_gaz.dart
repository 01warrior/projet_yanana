import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:yanana/vue/gaz/boutiquiers/listener.dart';
import 'package:yanana/vue/gaz/services/page_map.dart';
import 'package:yanana/models/gaz/suggest.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import '../../widget/animation_fade.dart';

class PageServiceGaz extends StatefulWidget {
  const PageServiceGaz({super.key});

  @override
  State<PageServiceGaz> createState() => PageServiceGazState();
}

class PageServiceGazState extends State<PageServiceGaz> {
  Position? localisationCourant;
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
            padding:const EdgeInsets.only(top: 60),
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
                  dropdownMenuEntries:listDropVille()
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

                    dropdownMenuEntries:const[//VOIR SI PEUT TAKE CES DATAS SUR LA BD
                      DropdownMenuEntry(value: "Total", label:"Total",),
                      DropdownMenuEntry(value: "Oryx", label:"Oryx"),
                      DropdownMenuEntry(value: "Pegaz", label:"Pegaz"),
                      DropdownMenuEntry(value: "Sodigaz", label:"Sodigaz"),
                      DropdownMenuEntry(value: "Shell", label:"Shell"),
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

                                const SpinKitDoubleBounce(
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
                margin:const EdgeInsets.all(20),
                child: Column(
                  children: [
                    LottieBuilder.asset("assets/images/write.json",),
                    DefaultTextStyle(
                        style: const TextStyle(
                          fontFamily: "Poppins",
                            fontSize: 18.0,
                            color:Colors.black87,
                        ), child: AnimatedTextKit(
                      pause:const Duration(seconds: 4) ,
                        totalRepeatCount: 8,
                        animatedTexts: [
                          TypewriterAnimatedText(
                              speed:const Duration(milliseconds:60),
                              'Veuillez renseigner toutes les données de recherche la haut',
                            textAlign: TextAlign.center,
                          ),
                        ],
                        isRepeatingAnimation: true,

                        onTap: () {
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
                                localisationCourant = await Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high,
                                );
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return WidgetMap(localisationCourant: localisationCourant,boutiqueClique: datas[index]['locate'],);
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
                  else if(datas.isEmpty && _switchV ){

                    return const Center(child: Text(" Le gaz choisi est indisponible"));
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
                            :Expanded(
                              child: ListView(
                                children: [
                                  AlertDialog(
                                    title:const Text("Gaz indisponible",style: TextStyle(fontSize:20,fontFamily: "Poppins"),),
                                    content: Column(
                                      children: [
                                        Image.asset("assets/images/empty.png",width:110),
                                        const Text("Il ya de grande chance que le produit que vous recherchez soit indisponible, néamoins vous pouvez voir les lieux de vente proches de chez vous. Nous ne garantissons pas la disponibilté du produit.",style: TextStyle(fontSize:13,fontFamily: "Poppins"),),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(onPressed: () {
                                         setState( (){_search = false;});
                                      }, child:const Text("Non merci",style: TextStyle(fontFamily: "Poppins"),)),
                                  
                                      TextButton(onPressed: ()
                                      {
                                        setState((){
                                          _switchV = _switchV ? false : true;
                                        });
                                      }, child:const Text("Oui voir",style: TextStyle(fontFamily: "Poppins"),)
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
                                ],
                              ),
                            ),
                            const SizedBox(height:10),
                          ]
                        ),
                      );
                    }

                }

                else if(snapshot.hasError)
                {
                  ElegantNotification.error(
                    notificationMargin:60,
                    title:const  Text("Oups"),
                    description:const  Text("Une erreur s'est produite", style: TextStyle(color: Colors.black)),
                    onDismiss: () {

                    },
                    animationDuration:const Duration(seconds: 4),
                  ).show(context);       // PETIT PROBLEME HERE QUAND ERREUR IL Y'A

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
  List<DropdownMenuEntry<String>> listDropVille(){
    final co = Provider.of<ListenerBoutiq>(context,listen:false);
    return co.getListVille.map((e) {
      return DropdownMenuEntry(label: e.toString(),value:e.toString());
    }).toList() ;
  }
}


  