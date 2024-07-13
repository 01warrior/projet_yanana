import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


// PERMET D'AFFICHER LES DIFFERENTES ICONES DES TYPES DE CONTACTS
//                                                   PAR LESQUELS LE USER PEUT PASSER POUR NOUS CONTACTER
class Contact extends StatefulWidget{
  const Contact({super.key});
  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  bool taped=false;
  @override
  Widget build(BuildContext context){

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedContainer(
          duration:const Duration(milliseconds: 500) ,
          width:taped ? MediaQuery.of(context).size.width /1.9 : 0,
          height:40,
          child:ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(
                onPressed: ()async{
                  await makePhoneSMS();
                },
                icon: Icon(Icons.sms,color:Colors.blueAccent.shade700) ,
              ),
              IconButton(
                onPressed: ()async{
                  await makeCall();
                },
                icon: Icon(Icons.call,color:Colors.blueAccent.shade700) ,
              ),
              IconButton(
                onPressed: ()async{
                  await makeEmailSMS();
                },
                icon: Icon(Icons.mail,color:Colors.blueAccent.shade700) ,
              ),
              IconButton(
                onPressed: ()async{
                  await makeWhatSMS();
                },
                icon: Icon(Icons.phone,color:Colors.blueAccent.shade700) ,
              ),
            ],
          )
        ),
        GestureDetector(
          onTap: (){
            setState(() {
              taped= !taped;
            });
          },
          child:const Icon(Icons.contact_phone_outlined,size:40,),
        ),
      ],
    );
  }


Future <void> makePhoneSMS()async{
  final url = Uri(
    scheme:'sms',
    path: '57122223',
    //queryParameters: {'body':body}
  );
  if(!await launchUrl(url)){
    print('ERROR');
  }
}

Future <void> makeWhatSMS()async{
  final url = Uri(
    scheme:'https',
    host:'wa.me',
    path:'71503265',
    //queryParameters: {'text':sms}
  );
  if(!await launchUrl(url)){
    print('ERROR');
  }
}

Future <void> makeEmailSMS()async{
  final url = Uri(
    scheme:'mailto',
    path:'tmaebusiness01@gmail.com',
  );
  if(!await launchUrl(url)){
    print('ERROR');
  }
}

Future <void> makeCall()async{
  final url = Uri(
    scheme:'tel',
    path:'57122223',
  );
  if(!await launchUrl(url)){
    print('ERROR');
  }
}
 

}