import 'package:counttestapp/Screens/opening.dart';
import 'package:counttestapp/providers/count.dart';
import 'package:counttestapp/providers/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        Provider<FlutterFireAuthService>(
          create: (_) => FlutterFireAuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<FlutterFireAuthService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterFire Provider Template',
        home: OpeningView(),
      ),
    );
  }
}
