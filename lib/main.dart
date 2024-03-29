import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider(
      create: (context) => ListenerBoutiq(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yanana',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent.shade700),
          useMaterial3: true,
        ),
        home:PageIntroductive(),
      ),
    );
  }
}
