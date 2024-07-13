import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class RecupCompte extends StatefulWidget{
  const RecupCompte({super.key});
  @override
  State<RecupCompte> createState() => _RecupCompteState();
}

class _RecupCompteState extends State<RecupCompte> {
  final _formKey = GlobalKey<FormState>();

  final _emailC = TextEditingController();
  bool _loading = false;
  bool _emailSend = false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
    //  resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar:true ,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //couleur des icone a white
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body:Container(
        padding:EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.black,
            Colors.blueAccent.shade700
          ],
            begin: Alignment.topCenter,
            end:Alignment.bottomCenter
          )
        ),
        child:ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:MediaQuery.of(context).size.height / 4),
            Center(
              child: Text("Récupération de compte",style:TextStyle(color:Colors.white,fontSize: 20,fontWeight:FontWeight.bold))),
            const SizedBox(height:20),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),                         
              child:Form(
                key:_formKey,
                child: Column(
                  children: [
                    const SizedBox(height:50),
                    TextFormField(
                      controller:_emailC,
                      validator:(val){
                        if( val == null || val.trim().contains(' ') || val.trim() == '' ){
                          return 'Saisissez un email valide';
                        }
                      },
                      decoration:InputDecoration(
                        hintText: ' Email',
                        prefixIcon:Icon(Icons.mail,color:Colors.blue.shade700),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700),borderRadius: BorderRadius.circular(30)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color:Colors.blue.shade700))
                      )
                    ),
                    const SizedBox(height:20),
                    SizedBox(
                      width:double.infinity,
                      child: ElevatedButton(
                        onPressed: ()async{
                          
                          if (_formKey.currentState!.validate()){
                            setState(() {
                              _loading = true;
                            });
                            await resetPassword();
                            if(_emailSend){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 3),
                                  content:Text("Vérifiez votre boite mail"))
                              );
                              setState( (){ _emailSend = false;});
                              _emailC.text = '';
                            }
                          }
                        }, 
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:_loading ? const CircularProgressIndicator(color:Colors.white) :const Text('Valider',style: TextStyle(color:Colors.white))
                      )
                    ),
                    const SizedBox(height:20),
                      ],
                    ),
                  )
                
              
            )
          ],
        )
      )
    );
  }

  resetPassword()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
      email: _emailC.text.trim()
      );
      setState(() {
        _loading = false;
        _emailSend = true;
      });
    }on FirebaseAuthException catch(e){
      setState(() {
        _loading = false;
      });
      if(e.code == "auth/invalid-email"){
        debugPrint("Email invalide ");
      }
    }
  }
}