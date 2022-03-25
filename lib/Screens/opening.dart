import 'package:counttestapp/Screens/homePage.dart';
import 'package:counttestapp/Screens/login.dart';
import 'package:counttestapp/Screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class OpeningView extends StatefulWidget {
  OpeningView({Key? key}) : super(key: key);

  @override
  _OpeningViewState createState() => _OpeningViewState();
}

class _OpeningViewState extends State<OpeningView> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      print("Home View");
      return MyHomePage();
    }

    print("Not Authenticated");

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 2.5),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blue,
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterView(),
                    ),
                  );
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                  );
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}