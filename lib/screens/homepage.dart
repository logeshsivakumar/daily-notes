import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Column(
        children: [
          Text("HOME"),
          ElevatedButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          }, child: Text("Sign out"))
        ],
      )),
    );
  }
}
