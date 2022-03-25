import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counttestapp/Screens/login.dart';
import 'package:counttestapp/Screens/register.dart';
import 'package:counttestapp/providers/count.dart';
import 'package:counttestapp/providers/firebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> _usersDocument = FirebaseFirestore.instance
      .collection('users')
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test App'),
        actions: [
          InkWell(
              onTap: () {
                print("Sign Out Pressed");
                context.read<FlutterFireAuthService>().signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginView(),
                  ),
                );
              },
              child: Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _usersDocument,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            return Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: InkWell(
                    onTap: () {
                      print("Sign Out Pressed");
                      context.read<FlutterFireAuthService>().signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterView(),
                        ),
                      );
                    },
                    child: Text(
                      "Go to SignUp Page",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    debugPrint('$data');
                    int value = data['value'];

                    debugPrint('$value'); // <= Should print the doc id
                    debugPrint('${document.id}');
                    Counter.withDoc(docId: document.id);

                    return Count(value: value);
                  }).toList(),
                ),
              ],
            ));
          }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            key: Key('increment_floatingActionButton'),
            onPressed: () => context.read<Counter>().increment(),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class Count extends StatelessWidget {
  Count({Key? key, required this.value}) : super(key: key);

  int value;

  @override
  Widget build(BuildContext context) {
    return Text('$value',
        key: Key('counterState'), style: Theme.of(context).textTheme.headline4);
  }
}
