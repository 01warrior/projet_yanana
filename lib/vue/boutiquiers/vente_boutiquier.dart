import 'package:flutter/material.dart';

class Vente_boutiquier extends StatefulWidget {
  const Vente_boutiquier({super.key});

  @override
  State<Vente_boutiquier> createState() => _Vente_boutiquierState();
}

class _Vente_boutiquierState extends State<Vente_boutiquier> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(30),

          decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))
          ),

          child: Column(
            children: [
              Row(
                children: [
                  Text("Gaz :",style: TextStyle(color: Colors.white,fontSize: 18),),

                  SizedBox(width: 43,),

                  DropdownMenu(
                    width: 200,
                    selectedTrailingIcon:Icon(Icons.arrow_drop_up,color: Colors.blue,size: 25,),

                    hintText: "Ex:total",
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
                      DropdownMenuEntry(value: "Total", label:"Total"),
                      DropdownMenuEntry(value: "Oryx", label:"Oryx"),
                      DropdownMenuEntry(value: "Pegaz", label:"Pegaz"),
                      DropdownMenuEntry(value: "Sodigaz", label:"Sodigaz"),
                    ],
                    onSelected: (value) {

                    },
                  ),

                ],
              ),

              SizedBox(height: 30,),

              Row(
                children: [
                  Text("Poid :",style: TextStyle(color: Colors.white,fontSize: 18),),

                  SizedBox(width: 40,),

                  DropdownMenu(
                    width: 200,
                    selectedTrailingIcon:Icon(Icons.arrow_drop_up,color: Colors.blueAccent.shade700,size: 25,),

                    hintText: "Ex:12kg",
                    menuStyle:MenuStyle(
                      shadowColor:MaterialStatePropertyAll(Colors.black87 ),
                      shape:MaterialStatePropertyAll(
                          RoundedRectangleBorder(borderRadius:BorderRadius.circular(30))
                      ),
                    ),

                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),

                    ),

                    dropdownMenuEntries:[
                      DropdownMenuEntry(value: "12 kg", label:"12 Kg"),
                      DropdownMenuEntry(value: "6 kg", label:"6 Kg"),
                    ],
                    onSelected: (value) {

                    },
                  ),

                ],
              ),

              SizedBox(height: 30,),

              Row(
                children: [
                  Text("Quantité :",style: TextStyle(color: Colors.white,fontSize: 18),),

                  SizedBox(width: 10,),

                  Container(width: 200,
                    child: TextFormField(
                      decoration: InputDecoration(

                          filled: true,
                          fillColor: Colors.white,

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(20)),

                          hintText: "Ex : 20"
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

        ),


        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height:90 ,
                width: 300,
                child: ElevatedButton(onPressed: () {

                }, child: Text("Vendre",style: TextStyle(fontSize:25),)),
              )
            ],
          ),
        )
      ],
    );
  }
}
