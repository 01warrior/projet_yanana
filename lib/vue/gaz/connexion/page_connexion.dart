import 'package:flutter/material.dart';
import 'package:yanana/vue/gaz/boutiquiers/accueil_boutiquier.dart';
import 'page_creationCompte.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'page_recuperationCompte.dart';





class VerifConnexion extends StatelessWidget{

  @override
  Widget build(BuildContext){
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: ((context, snapshot) {
        if(snapshot.hasError){
          debugPrint(' On a une erreur bro');
        }
        if( snapshot.hasData){
          return Accueil_boutiquier();
        }
        return PageConnexion();
      })
    );
  }
}


class PageConnexion extends StatefulWidget {
  const PageConnexion({super.key});

  @override
  State<PageConnexion> createState() => _PageConnexionState();
}

class _PageConnexionState extends State<PageConnexion> {

  bool seSouvenir=false;
  final _formKey = GlobalKey<FormState>();
  final _emailC= TextEditingController();
  final _passwordC = TextEditingController();
  bool _loading = false;
  bool _hide = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //eviter le redimentionnement de lecran notamment lme overflow lors de la sortie du clavier
     // resizeToAvoidBottomInset: false,

      body: Container(
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
            Image.asset("assets/images/icone_services.png",width: 150,),
            const Text("YANANA",style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.w700),),
            const Text("SERVICES",style: TextStyle(color: Colors.white,fontSize: 25),),

            Container(
              margin: EdgeInsets.all(25),
              padding: EdgeInsets.all(25),
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView(//Column modified by listview
                children: [
                  Form(
                    key:_formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller:_emailC,
                          validator:(val){
                            if( val == null || val.trim().contains(' ') || val.trim() == '' ){
                              return 'Saisissez un email valide';
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)
                              ),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(30)),

                              prefixIcon:Icon(Icons.person_4,color: Colors.blueAccent.shade700,),
                            hintText: "email"
                          ),
                        ),

                        const SizedBox(height: 15,),

                        TextFormField(
                          controller:_passwordC,
                          obscureText: _hide,
                          validator:(val){
                            if( val == null || val.trim().contains(' ') || val.trim() == '' ){
                              return 'Saisissez un mot de passe valide';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(30)),
                            prefixIcon:Icon(Icons.lock,color: Colors.blueAccent.shade700,),
                            suffixIcon:IconButton(
                                  onPressed: () {
                                    setState( (){_hide=!_hide;});
                              }, icon: Icon(Icons.remove_red_eye_rounded,color: Colors.blueAccent.shade700,)),
                              hintText: "Mot de passe"
                          ),

                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  
                  
                 
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.black),
                      ),

                      onPressed: () {
                        if( _formKey.currentState!.validate()){
                          setState(() {
                            _loading = true;
                          });
                          connectCompte();
                       }

                      }, 
                      child:_loading ? const CircularProgressIndicator(color:Colors.white) : const Text("Se connecter",style: TextStyle(color: Colors.white),)),
                  ),
                   const SizedBox(
                    height: 2,
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RecupCompte() )
                      );
                    }, 
                    child: Text('Mot de passe oublié',style:TextStyle(decoration:TextDecoration.underline))
                  ),
                 /* Center(
                    child: GestureDetector(
                     
                      child: Text('Mot de passe oublié',style:TextStyle(color:Colors.blueAccent.shade700,decoration:TextDecoration.underline )),
                       onTap:(){
                        debugPrint(" Yoooooo ");
                      },
                    ),
                  ),*/
                  const SizedBox(
                    height: 3,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Pas de compte ?",style: TextStyle(fontSize: 11,),),
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) {
                          return PageCreationCompte();
                        },));
                      }, child: Text("Créer un compte ",style: TextStyle(fontSize: 12,color: Colors.blueAccent.shade700)),)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  connectCompte()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailC.text.trim(), 
      password: _passwordC.text.trim()
      );
    }on FirebaseAuthException catch (e){
        setState(() {
          _loading = false;
        });
        if (e.code == "invalid-email"){
          debugPrint("l'email saisie est invalide");
        }else if(e.code == "user-disabled"){
          debugPrint(" l'utilisateur est désactivé");
        }else if (e.code == "user-not-found"){
          debugPrint(" Aucun utilisateur ne correspond à cet email");
        }else if(e.code == "wrong-password"){
          debugPrint("mot de passe incorrect");
        }
    }
  }
}
