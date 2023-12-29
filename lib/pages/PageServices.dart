import 'package:flutter/material.dart';
import 'package:yanana/pages/PageConnexion.dart';

class PageServices extends StatefulWidget {
  const PageServices({super.key});

  @override
  State<PageServices> createState() => _PageServicesState();
}

class _PageServicesState extends State<PageServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        elevation: 1,
        centerTitle: true,
        title: Text("Services",style: TextStyle(color: Colors.white),),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton.outlined(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                  return Pageconnexion();
                },));
            }, icon: Icon(Icons.person,color: Colors.blueAccent.shade700,size: 30,)),
          )
        ],
        backgroundColor: Colors.black87,
      ),

      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            height: 150,
            width: double.infinity,
            
            decoration: BoxDecoration(
              image: DecorationImage(image:AssetImage("assets/images/place_martyrs.png")),
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(15)
            ),

            child:Text("Facilitez vous la vie",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
          ),

        GridView(
              shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
              padding: EdgeInsets.all(10),
              children: [

            Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(15)
                      ),

                      child: Column(
                        children: [
                          Image(image: AssetImage("assets/images/icone_gaz.png",),width: 100,),
                          Divider(color: Colors.white60),
                          Text("Lieu de recharge",style: TextStyle(color: Colors.white,shadows: [
                            Shadow(color: Colors.black87,offset: Offset(1, 1))
                          ]))
                        ],
                      ),
                    ),



                Container(

                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(),
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(15)
                    ),

                    child: Column(
                      children: [
                        Image(image: AssetImage("assets/images/camion_vidange.png"),width: 100,),

                        Divider(color: Colors.white60),

                        Text("Camion vidange",style:  TextStyle(color: Colors.white,shadows: [
                          Shadow(color: Colors.black87,offset: Offset(1, 1))
                        ]))
                      ],
                    ),
                  ),

                Container(

                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(15)
                  ),

                  child: Column(
                    children: [
                      Image(image: AssetImage("assets/images/camion_vidange.png"),width: 100,),
                      Divider(color: Colors.white60),
                      Text("Lavage a domicile",style:  TextStyle(color: Colors.white,shadows: [
                        Shadow(color: Colors.black87,offset: Offset(1, 1))
                      ]))
                    ],
                  ),
                ),


                Container(

                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(15)
                  ),

                  child: Column(
                    children: [
                      Image(image: AssetImage("assets/images/camion_vidange.png"),width: 100,),
                      Divider(color: Colors.white70),
                      Text("Depanneurs",style: TextStyle(color: Colors.white,shadows: [
                        Shadow(color: Colors.black87,offset: Offset(1, 1))
                      ]),)
                    ],
                  ),
                ),

              ],
            ),

        ],
      ),
    );
  }
}
