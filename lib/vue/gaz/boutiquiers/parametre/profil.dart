
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanana/models/gaz/boutiquier_back.dart';
import 'package:yanana/vue/gaz/boutiquiers/listener.dart';

class ProfilBottomSheet extends StatefulWidget{
  const ProfilBottomSheet({super.key});

  @override
  State<ProfilBottomSheet> createState() => _ProfilBottomSheetState();
}

class _ProfilBottomSheetState extends State<ProfilBottomSheet> {
  bool input=true;
  final _formKey = GlobalKey<FormState>();
  String oldNom = '';
  String oldTel = '';

  @override
  void initState(){
    super.initState();
    final profil =Provider.of<ListenerBoutiq>(context,listen: false);
    oldNom = profil.getNom;
    oldTel = profil.getTelephone;

  }
  @override
  Widget build(BuildContext context){
    final profil =Provider.of<ListenerBoutiq>(context,listen: false);
    return Container(
      margin: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
      decoration:const BoxDecoration(
        borderRadius:BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30) ) ,
        color:Colors.white,
        boxShadow: [BoxShadow(blurRadius: 2)]
        ) ,
      width:double.infinity,
      height:300,
      child:  SingleChildScrollView(
        child: Form(
          key: _formKey,
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller:profil.getNomC,
                  readOnly: input,
                  decoration:const InputDecoration(
                    icon:Icon(Icons.person,color:Colors.orange),
                    hintText: "Nom de l'entreprise"
                  ),
                  validator: validatorNom
                ),
                const SizedBox(height: 25,),
                TextFormField(
                  controller:profil.getTelephoneC,
                  readOnly: input,
                  decoration:const InputDecoration(
                    icon:Icon(Icons.phone,color:Colors.orange),
                    hintText: "Numéro de l'entreprise"
                  ),
                  validator: validatorNum
                 
                ),
                const SizedBox(height: 25,),
                TextFormField(
                  controller:profil.getEmailC,
                  readOnly: true,
                  decoration:const InputDecoration(
                    icon:Icon(Icons.mail,color:Colors.orange),
                    hintText: "Email de l'entreprise"
                  ),
                  validator: (val){
                    if(val == '') return 'saisissez un email';
                    return null;
                  },
                ),
                const SizedBox(height: 25,),
                ElevatedButton(
                  style:const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(200,50))
                  ),
                  onPressed: ()async{
                    //makeSafe( ecoutP);// REFACTOR LES DATAS SAISIES AVANT ENREGISTREMENT

                    if(!input){
                      if(_formKey.currentState!.validate()){
                       // DBParam().updateProfil(context: context);
                        if(oldNom != profil.getNomC.text || oldTel != profil.getTelephoneC.text){
                          debugPrint('Modiaaaaaaaaaaaaaaaaaaaaa///////////');
                          await BoutiquierBack().updateProfil(context: context, nom: profil.getNomC.text, tel: profil.getTelephoneC.text);
                          oldNom = profil.getNomC.text;
                          oldTel = profil.getTelephoneC.text;
                        }
                        setState(() {
                          input = !input;
                        });
                      }
                    }
                    else if(input){
                      setState(() {
                        input = !input;
                      });
                    }
                    
                    
                    
                  }, 
                  child:input ?const Text('modifier',style:TextStyle(color: Colors.red))
                              :const Text('valider',style:TextStyle(color: Colors.red))
                )
              ]
            ),
          ) ,
        ),
      ) 
      ); 
  }
 /* makeSafe( ListenerParam ecoutP){
    //final ecoutP = Provider.of<ListenerParam>(context);
    var listC = [ecoutP.getEmailC,ecoutP.getNameC,ecoutP.getNumC];
    for (int i=0;i<listC.length;i++ ){
      listC[i].text=listC[i].text.trim();
      if( i !=1){listC[i].text = listC[i].text.replaceAll(' ', ''); }
      
    }
  }*/

  String? validatorNom(String? val){
    if(val == '' || val!.trim() == '') return 'saisissez un nom';
    return null;
  }
  bool isInt(String? val){
    
    try{
      int.parse(val!.trim());
      return true;
    }catch(e){
      return false;
    }
  }
  String? validatorNum(String? val){
    if(val == '' || isInt(val)==false) return 'saisissez un Numero valide';
    return null;
  }
}