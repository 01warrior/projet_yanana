import 'package:flutter/material.dart';

class Page_service_gaz extends StatefulWidget {
  const Page_service_gaz({super.key});

  @override
  State<Page_service_gaz> createState() => _Page_service_gazState();
}

class _Page_service_gazState extends State<Page_service_gaz> {

  //late pour dire que ma variable sera initialiser plus tard dans le code  je vais linitialiser dans le initstate
  //late Type nomVariable;


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 2,
      initialIndex: 0,

      child: Scaffold(
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
                textStyle: TextStyle(fontSize: 20),
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

           TabBar(
                  tabs: [
                    Tab(
                    child: Text("Carte des lieux",style: TextStyle(color: Colors.black87),),
                  ),

                    Tab(
                      child: Text("Lieux plus proche",style: TextStyle(color: Colors.black87),),
                    )
                  ],

                ),

            Expanded(

              child: TabBarView(

                  children: [
                    Container(),

                    Container(
                      child: ListView.builder(
                        padding: EdgeInsets.all(15),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.map),
                            title: Text("Boutique"),
                            trailing:Text("3 Km",style: TextStyle(fontSize: 18,fontFamily: "Poppins"),),
                          ),
                        );
                      },),
                    )
              ]
              ),

            )

          ],
        ),
      ),
    );
  }
}
