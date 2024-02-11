import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PageCreationCompte extends StatefulWidget {
  const PageCreationCompte({super.key});

  @override
  State<PageCreationCompte> createState() => _PageCreationCompteState();
}

class _PageCreationCompteState extends State<PageCreationCompte> {
  final _formKey = GlobalKey<FormState>();
  final _nomC = TextEditingController();
  final _emailC = TextEditingController();
  final _mdpC = TextEditingController();
  final _mdprC = TextEditingController();
  final _telC = TextEditingController();
  bool _input = true;
  bool _loading = false;
  bool _hidem = true;
  bool _hidemr = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //ici jetend le body derriere lappba que je met a transparent
        extendBodyBehindAppBar:true ,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //couleur des icone a white
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body:Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black,
              Colors.blueAccent.shade700
            ],
                begin: Alignment.topCenter,
                end:Alignment.bottomCenter
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("CREATION DE COMPTE",style: TextStyle(color: Colors.white,fontSize: 25),),

            Container(
              margin: EdgeInsets.all(25),
              padding: EdgeInsets.all(25),
            //  height:300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Form(
                    key:_formKey,
                    child: Column(
                      children: [

                        TextFormField(
                          controller:_nomC,
                          validator: (val){
                            if (val == null || val.trim() == ''){
                              return 'Veuillez saisir un nom valide';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(30)),
                              hintText: "Nom d'utilisateur"
                          ),
                        ),

                        const SizedBox(height: 15,),
                        TextFormField(
                          controller:_telC,
                          validator: (val){
                            if(val == null || val.trim().contains(' ') || val.trim() == '' || val.trim().length != 8 ){
                              return 'Veuillez saisir un numero valide';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(30)),
                              
                              hintText: "Telephone"
                          ),

                        ),
                        const SizedBox(height: 15,),
                        TextFormField(
                          controller:_emailC,
                          validator: (val){
                            if(val == null || val.replaceAll(' ', '') == '' || val.trim().contains(' ')){
                              return 'Veuillez saisir une adresse email valide';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(30)),
                              hintText: "Adresse email"
                          ),
                        ),

                        const SizedBox(height: 15,),

                        TextFormField(
                          controller:_mdpC,
                          obscureText: _hidem,
                          validator: (val){
                            if(val == null || val.trim().contains(' ') || val.trim() == '' ){
                              return 'Veuillez saisir un mot de passe valide';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(30)),
                              suffixIcon:IconButton(
                                  onPressed: () {
                                    setState( (){_hidem= !_hidem;});
                              }, icon: Icon(Icons.remove_red_eye_rounded,color: Colors.blueAccent.shade700,)),
                              hintText: "Mot de passe"
                          ),

                        ),

                        const SizedBox(height: 15,),

                        TextFormField(
                          controller:_mdprC,
                          readOnly:_input,
                          obscureText: _hidemr,
                          validator: (val){
                            if(val == null || val.trim() == '' || val.trim().contains(' ')){
                              return 'Veuillez saisir une adresse email valide';
                            }
                            return null;
                          },
                          onTap:(){
                            if(_mdpC.text.replaceAll(' ', '') != '' ){
                              setState(() {
                                _input=false;
                              });
                            }else{
                               setState(() {
                                _input=true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("veuillez saisir un mot de passe d'abord"),)
                              );
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(30)),
                              suffixIcon:IconButton(
                                  onPressed: () {
                                    setState( (){_hidemr = !_hidemr;});
                                  }, icon: Icon(Icons.remove_red_eye_rounded,color: Colors.blueAccent.shade700,)),
                              hintText: "Repetez le mot de passe"
                          ),

                        ),
                        const SizedBox(height: 15,),
                  _loading ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),

                        onPressed: () async{
                          if(_formKey.currentState!.validate() ){
                            if( _mdpC.text.compareTo( _mdprC.text ) != 0 ){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('mots de passe non semblable'))
                              );
                            }else{
                              
                              setState( (){_loading=true;});
                              bool create = await createCompte();
                              setState( (){_loading=false;});
                            //  Navigator.of(context).pop();
                              if(create){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content:Text('Compte créer avec succès'))
                                );
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content:Text('Creation de compte échoué '))
                                );
                              }
                            }
                          }

                        }, child: Text("Créer",style: TextStyle(color: Colors.white),)),
                  ) ,
                      ],
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Future<bool> createCompte()async{
    bool create = false;
    try{
      
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email:_emailC.text.trim(),
        password:_mdpC.text.trim()
      );
      final id = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(id)
      .set({
        'telephone':_telC.text.trim(),
        'nom':_nomC.text.trim(),
        'email':_emailC.text.trim()
        }
      );
      create = true;
      debugPrint(" c'est carré bro !!");
      eraseFields();
    }on FirebaseAuthException catch(e){
      debugPrint('$e');
      if( e.code == "email-already-in-use"){
        debugPrint(" l'email est déja utilisé ");
      }else if( e.code == "invalid-email"){
        debugPrint (" l'email utilisé est invalde ");
      }else if( e.code == "operation-not-allowed"){
        debugPrint (" votre compte est désactivé");
      }else if (e.code == "weak-password"){
        debugPrint(" mot de passe court");
      }
    }
    return create;
  }
  eraseFields(){
    _mdpC.text='';
    _mdprC.text='';
    _emailC.text= '';
    _nomC.text='';
    _telC.text='';
  }
}
