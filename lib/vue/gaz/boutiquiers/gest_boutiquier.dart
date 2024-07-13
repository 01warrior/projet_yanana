import 'package:flutter/material.dart';
import 'package:yanana/vue/gaz/boutiquiers/listener.dart';
import 'package:provider/provider.dart';
import 'package:yanana/models/gaz/boutiquier_back.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yanana/vue/gaz/boutiquiers/waiting_page.dart';
class GestBoutiquier extends StatefulWidget{
  const GestBoutiquier({super.key});

  @override
  State<GestBoutiquier> createState() => _GestBoutiquierState();
}

class _GestBoutiquierState extends State<GestBoutiquier> {
  bool checked = false;
 /* @override
  void initState(){
    super.initState();
    BoutiquierBack().recupData(context);

  }*/
  @override
  Widget build(BuildContext context){
    final ecoutStock = Provider.of<ListenerBoutiq>(context);
    return ListView.builder(
          padding:EdgeInsets.all(15.0),
          itemCount: ecoutStock.getListGazVendu.length,
          itemBuilder: (context,index){
            String name = ecoutStock.getListGazVendu[index];
            
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(15),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  tileColor:name.contains('Oryx',) ? Colors.red.shade300: name.contains('Total') ? Colors.orange.shade300 : name.contains('Sodigaz') ? Colors.blueAccent.shade200 : Colors.green.shade300,
                  leading: Icon(Icons.gas_meter,size:40,color: Colors.white70,),
                  title: Text(name,style: TextStyle(fontFamily: "Poppins"),),
                  trailing: Checkbox(
                    value: ecoutStock.getListGazDispo.contains(name), 
                    onChanged: (e){
                      showDialog(
                        context: context, 
                        builder: (context) => AlertDialog(
                          title: Text('Validation'),
                          content: Text("Vous confirmez que vous avez ce produit ??"),
                          actions: [
                            TextButton(
                              onPressed: ()async{
                                e! ? setState((){ecoutStock.getListGazDispo.add(name) ;}) : setState((){ecoutStock.getListGazDispo.remove(name) ;}) ;
                                await BoutiquierBack().updateGazDispo(docGaz: name, dispo: e);
                                Navigator.of(context).pop();
                              }, 
                              child: Text('Oui')
                            ),
                            TextButton(
                              onPressed: (){Navigator.of(context).pop(); }, 
                              child: Text('Non')
                            ),
                          ],
                        )
                      );
                      
                    }
                  )
                ),
                const SizedBox(height:20)
              ],
            );
          }
        );
      
  }
}

