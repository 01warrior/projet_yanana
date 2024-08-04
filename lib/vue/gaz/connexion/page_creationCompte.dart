import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:yanana/vue/gaz/connexion/listener.dart';
import 'package:geolocator/geolocator.dart';

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
  final _villeC = TextEditingController();
  bool _input = true;
  bool _loading = false;
  bool _hidem = true;
  bool _hidemr = true;
  bool _errorV = false;
  GeoPoint _locateSeller =GeoPoint(12, 110) ;
  
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
        height:double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black,
              Colors.blueAccent.shade700
            ],
                begin: Alignment.topCenter,
                end:Alignment.bottomCenter
            )
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("CREATION DE COMPTE",style: TextStyle(color: Colors.white,fontSize: 25),),
            
                Container(
                  margin:const EdgeInsets.all(25),
                  padding:const EdgeInsets.all(25),
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
                            DropdownMenu(
                              controller:_villeC,
                              width:MediaQuery.of(context).size.width/1.4 ,
                              label:const Text('Ville') ,
                              errorText: _errorV ? 'Faites un choix' : null,
                              expandedInsets:null,
                              inputDecorationTheme: InputDecorationTheme(
                                border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(30.0))),
                              ),
                              menuStyle:MenuStyle(
                              shape:MaterialStatePropertyAll(
                                  RoundedRectangleBorder(borderRadius:BorderRadius.circular(30))
                              ),
                              shadowColor:const MaterialStatePropertyAll(Colors.black87 ),
                            ),
                              dropdownMenuEntries:listDropVille()
                            ),
                            const SizedBox(height: 15,),
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
                              
                              //await checkingLocate(); // for testing before deleting
                              
                              if(_formKey.currentState!.validate() && _villeC.text != ''){
                                setState(() {
                                  _errorV = false;
                                });
                                if( _mdpC.text.compareTo( _mdprC.text ) != 0 ){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('mots de passe non semblable'))
                                  );
                                }else{
                                  showDialog(
                                    context: context, 
                                    builder: (context) =>const AlertDialog(
                                      title:Column(
                                        children: [
                                          Center(child:  CircularProgressIndicator()),
                                          Text('Patienter',style: TextStyle(fontSize:12, ),),
                                        ],
                                      ),
                                    )
                                  );
                                  bool locate = await checkingLocate();
                                  Navigator.of(context).pop();
                                  if(locate){
                                    setState( (){_loading=true;});
                                    bool create = await createCompte();
                                    setState( (){_loading=false;});
                                  //  Navigator.of(context).pop();
                                    if(create){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content:Text('Compte créer avec succès'))
                                      );
                                      FirebaseAuth.instance.signOut();
                                      Navigator.of(context).pop();
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content:Text('Creation de compte échoué '))
                                      );
                                    }
                                  }else{
            
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Prise des données de localisation échoué.Reéssayer svp!!'),
                                        
                                      )
                                    );
                                  }
                                }
                              }else{
                                if(_villeC.text != ''){
                                  setState(() {
                                    _errorV  = false;
                                  });
                                }else{
                                  setState(() {
                                    _errorV  = true;
                                  });
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
          ),
        ),
      )
    );
  }
   List<DropdownMenuEntry<String>> listDropVille(){
    final co = Provider.of<ListenerCo>(context,listen:false);
    return co.getListVille.map((e) {
      return DropdownMenuEntry(label: e.toString(),value:e.toString());
    }).toList() ;
  }

  Future<bool> createCompte()async{
    bool create = false;
    try{
      
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email:_emailC.text.trim(),
        password:_mdpC.text.trim()
      );
      final id = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection(_villeC.text.trim()).doc(id)
      .set({
        'telephone':_telC.text.trim(),
        'nom':_nomC.text.trim(),
        'email':_emailC.text.trim(),
        'ville':_villeC.text.trim(),
        'locate':_locateSeller,
        'verify':false
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

  Future<bool> checkingLocate()async{

    LocationPermission permission = await Geolocator.checkPermission();
    debugPrint('////// $permission  ////');
    if(permission == LocationPermission.denied){
      debugPrint('MOMOCHI ATAKE OMOYE');
      permission = await Geolocator.requestPermission();
    }
    else if(permission == LocationPermission.deniedForever ){
      
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title:Text('Attention!!!'),
          content:Text("Vous devez autoriser l'application à accéder à la position du téléphone dans vos paramètres.Sinon la création du compte sera impossible."),
          actions: [
            TextButton(onPressed: (){Navigator.of(context).pop();},child:Text('Ok'))
          ],)
      );
      return false;
    }
    Position position;
    try{
      position = await Geolocator.getCurrentPosition();
      _locateSeller = GeoPoint(position.latitude,position.longitude);
      debugPrint('Tu as tres bien   active la locato');

      debugPrint('Latitude ::: ${_locateSeller.latitude}   Longitude ::: ${_locateSeller.longitude}');
      return true;
    }on LocationServiceDisabledException catch(e){
      debugPrint('MOdiaaaaa batraciennnnnnn diseable // $e');
      return false;
    }
    
    /*bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(serviceEnabled){
      _locateSeller = GeoPoint(position!.latitude,position.longitude);
      debugPrint('Tu as tres bien   active la locato');
      return true;
    }
    debugPrint('Tu as pas   active la locato');
    return false;*/
    
  }
  eraseFields(){
    _mdpC.text='';
    _mdprC.text='';
    _emailC.text= '';
    _nomC.text='';
    _telC.text='';
  }
}
