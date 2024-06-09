import 'package:flutter/material.dart';


class Localisation extends StatelessWidget{
  const Localisation({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:const Text('Localisation'),),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child:Icon(Icons.location_on)
      ),
    );
  }
}