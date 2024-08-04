import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanana/vue/gaz/connexion/listener.dart';
import 'package:yanana/vue/page_introductive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:yanana/vue/gaz/boutiquiers/listener.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => ListenerBoutiq()), 
        ChangeNotifierProvider(create: (context) => ListenerCo()), 
        
      ],
      child: MaterialApp( 
        debugShowCheckedModeBanner: false,
        title: 'Yanana',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          
          useMaterial3: true,
        ),
        home:const PageIntroductive(),
      ),
    );
  }
}
