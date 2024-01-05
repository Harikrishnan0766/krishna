import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_recod_app/home.dart/screen_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
        
        apiKey: "AIzaSyCxD6cmm7XQ-0qEAoEnxzwmbBN0cIVHflc",

      appId: "1:75150388124:web:679e482361b1660fd3f659",
      messagingSenderId: "75150388124",
      projectId: "my-web-ca46f",
      storageBucket: "gs://my-web-ca46f.appspot.com",
    ));
  }
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ScreenHome(),
    );
  }
}
