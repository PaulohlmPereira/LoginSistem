import 'dart:async';

import 'package:dvsgse/main.dart';
import 'package:dvsgse/telaPrincipal/telaPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChecagemPage extends StatefulWidget {
  const ChecagemPage({super.key});

  @override
  State<ChecagemPage> createState() => _ChecagemPageState();
}

class _ChecagemPageState extends State<ChecagemPage> {


  StreamSubscription? streamSubscription;


  @override
  void initState() {
    super.initState();
    streamSubscription = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TelaPrincipal(),
          ),
        );
      }
    });
  }

  @override
  void dispose(){
    streamSubscription!.cancel();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
