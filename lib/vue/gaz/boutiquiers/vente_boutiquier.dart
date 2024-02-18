import 'package:flutter/material.dart';
import 'package:yanana/models/gaz/boutiquier_back.dart';
import 'package:provider/provider.dart';
import 'package:yanana/vue/gaz/boutiquiers/listener.dart';
import 'package:firebase_auth/firebase_auth.dart';
class VenteBoutiquier extends StatefulWidget {
  const VenteBoutiquier({super.key});

  @override
  State<VenteBoutiquier> createState() => _VenteBoutiquierState();
}

class _VenteBoutiquierState extends State<VenteBoutiquier> {
  final _formKey = GlobalKey<FormState>();  // VARIABLE QUI REPRESENTE LA CLEF DU WIDGET (Form)
  final _gazC = TextEditingController();  // VAR DU CONTROLLER DU CHAMPS GAZ
  final _poidsC = TextEditingController(); // VAR DU CONTROLLER DU CHAMPS POIDS
  final _quantiteC = TextEditingController(); // VAR DU CONTROLLER DU CHAMPS QUANTITE
  bool _choixP = true; // VARIABLE QUI PERMET DE SAVOIR SI UN CHOIX EST FAIT NIVEAU POIDS DU GAZ( AFIN D'ENVOYER UN MESSAGE AU USER SINON)
  bool _choixG = true;// VARIABLE QUI PERMET DE SAVOIR SI UN CHOIX EST FAIT NIVEAU DU GAZ( AFIN D'ENVOYER UN MESSAGE AU USER SINON)
  String _poidsValueSelected = "";
  bool _loading = true;
  @override
  void initState(){
    super.initState();
    BoutiquierBack().recupData(context);

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding:const EdgeInsets.all(30),

          decoration:const BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))
          ),

          child: Form(
            key:_formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("Gaz :",style: TextStyle(color: Colors.white,fontSize: 18),),           
                    const SizedBox(width: 43,),           
                    DropdownMenu(
                      width: 200,
                      selectedTrailingIcon:const Icon(Icons.arrow_drop_up,color: Colors.blue,size: 25,),
                      controller:_gazC,
                      hintText: "Ex:total",
                      errorText: _choixG ? null : 'Faites un choix' ,
                      menuStyle:MenuStyle(
                        shape:MaterialStatePropertyAll(
                            RoundedRectangleBorder(borderRadius:BorderRadius.circular(30))
                        ),
                        shadowColor:const MaterialStatePropertyAll(Colors.black87 ),
                      ),            
                      inputDecorationTheme:const InputDecorationTheme(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),        
                      ),           
                      dropdownMenuEntries:const [
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
            
                const SizedBox(height: 30,),
            
                Row(
                  children: [
                    const Text("Poids :",style: TextStyle(color: Colors.white,fontSize: 18),),            
                    const SizedBox(width: 40,),           
                    DropdownMenu(
                      width: 200,
                      selectedTrailingIcon:Icon(Icons.arrow_drop_up,color: Colors.blueAccent.shade700,size: 25,),
                      controller:_poidsC,
                      hintText: "Ex:12kg",
                       errorText: _choixP ? null : 'Faites un choix' ,
                      menuStyle:MenuStyle(
                        shadowColor:const MaterialStatePropertyAll(Colors.black87 ),
                        shape:MaterialStatePropertyAll(
                            RoundedRectangleBorder(borderRadius:BorderRadius.circular(30))
                        ),
                      ),           
                      inputDecorationTheme:const InputDecorationTheme(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            
                      ),
                      dropdownMenuEntries:const[
                        DropdownMenuEntry(value: "12", label:"12 Kg"),
                        DropdownMenuEntry(value: "6", label:"6 Kg"),
                      ],
                      onSelected: (value) {
                        setState(() {
                          _poidsValueSelected= value!;
                        });
                      },
                    ),
            
                  ],
                ),           
                const SizedBox(height: 30,),          
                Row(
                  children: [
                    const Text("Quantité :",style: TextStyle(color: Colors.white,fontSize: 18),),          
                    const SizedBox(width: 10,),            
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller:_quantiteC,
                        validator: (val){
                          if(val == null || !numVerify(val ) || val.trim().contains(' ') ){ // PERMET DE CONTROLER LES SAISIES DU USER AVANT DE TRAITER LES DATAS
                            return 'Veuillez saisir une quantité valide';
                          }
                          return null;
                        },
                        decoration:InputDecoration(        
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

        ),


        _loading ? Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 90,
                child: ElevatedButton(onPressed: () {
                  //FirebaseAuth.instance.signOut();
                  if( _formKey.currentState!.validate() && _poidsC.text != '' && _gazC.text != '' ){// PERMET DE CONTROLER LES SAISIES DU USER AVANT DE TRAITER LES DATAS
                    print('modiaaaaaa');
                    _quantiteC.text = _quantiteC.text.trim(); // SUPPRIMER LES ESPACES AUX EXTREMITE DE LA DATA SAISIE
                    setState(() {// SIGNALE QU'IL N'Y A PAS D'ERREUR DE SAISIE (NIVEAU POIDS ET GAZ) DONC N'ENVOIE PAS DE MESSAGE D'ERREUR
                      _choixP=true;
                      _choixG=true;
                    });
                    if( getQuantite() < int.parse(_quantiteC.text)){
                      showDialog(
                        context: context, 
                        builder: (context) => AlertDialog(
                          title:const Center(child: Text('Alerte !!!')),
                          actions:[
                            TextButton(
                              child:const Text('OK',style: TextStyle(fontSize:20 ),) ,
                              onPressed:(){
                                Navigator.of(context).pop();
                              }
                            )
                          ],
                          actionsAlignment: MainAxisAlignment.center,
                        )
                      );
                    }else{
                      showDialog(
                      context: context, 
                      builder: (contexte) {
                        return AlertDialog(
                          title:const Text('Valider la vente?'),
                          actions: [
                            TextButton(
                              onPressed: ()async{

                                setState( (){ _loading = false;});               
                                Navigator.of(context).pop();                
                                bool ajout=await BoutiquierBack().ajoutStock(context:context ,nomGaz: _gazC.text+_poidsValueSelected, nombre: getQuantite()-int.parse(_quantiteC.text) );
                                                               
                                setState( (){ _loading = true;});
                                if(ajout){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Mise â jour réussi'))
                                  );
                                  emptyField(); //PERMET DE VIDER LES CHAMPS UNE FOIS ENREGISTREMENT REUSSI 
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Mise â jour échoué'))
                                  );
                                }
                                
                              }, 
                              child:const Text('Oui')),
                            TextButton(

                              onPressed: (){Navigator.of(context).pop(); }, 
                              child: Text('Non'))
                          ],
                        ) ;
                      }
                    );

                    }
                    
                  }else{
                    if(_poidsC.text == ''){ // NOTIFIE D'ENVOYER LE MESSAGE D'ERREUR AU NIVEAU DU CHAMP(POIDS) SI AUCUN CHOIX N'EST FAIT
                      setState(() {
                        _choixP=false;
                      });
                    }else{ setState( (){_choixP=true;}); } //SI LE CHAMPS EST NON VIDE (_choixP PREND true) AUCUN SMS D'ERREUR N'EST ENVOYER
                    if(_gazC.text == ''){// NOTIFIE D'ENVOYER LE MESSAGE D'ERREUR AU NIVEAU DU CHAMP(GAZ) SI AUCUN CHOIX N'EST FAIT
                       setState(() {
                        _choixG=false;
                      });
                    }else{ setState( (){_choixG=true;}); } //SI LE CHAMPS EST NON VIDE (_choixG PREND true) AUCUN SMS D'ERREUR N'EST ENVOYER
                    
                  }
                }, child:const Text("Vendre",style: TextStyle(fontSize:25),)),
              )
            ],
          ),
        ): const Expanded(child: Center(child: CircularProgressIndicator()))
      ],
    );
  }
  bool numVerify(String val){ // METHODE PERMETTANT DE VERIFIER SI LA QUANTITE SAISIE EST UN ENTIER (RENVOIE true SI ENTIER SINON false)/VERIFIE AUSSI QUE LA VALEUR EST DIFF DE ZERO
    try{    
      if(int.parse(val.trim() ) <= 0){return false;}
      return true;
    }catch (e){
      return false;
    }
  }
  emptyField(){
    _gazC.text='';
    _poidsC.text='';
    _quantiteC.text='';
  }
  int getQuantite(){
    final ecoutStock = Provider.of<ListenerBoutiq>(context,listen: false);
    String name = _gazC.text+_poidsValueSelected;
    if(name == 'Oryx12'){
      return ecoutStock.getQteOryx12;
    }else if(name == 'Oryx6'){return ecoutStock.getQteOryx6;}
    else if(name == 'Total12'){return ecoutStock.getQteTotal12;}
    else if(name == 'Total6'){return ecoutStock.getQteTotal6;}
    else if(name == 'Sodigaz12'){return ecoutStock.getQteSodigaz12;}
    else if(name == 'Sodigaz6'){return ecoutStock.getQteSodigaz6;}
    else if(name == 'Pegaz12'){return ecoutStock.getQtePegaz12;}
    return ecoutStock.getQtePegaz6;
  }
}
