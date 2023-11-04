import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sistematizacao_dmm/controller/api.dart';
import 'controller/utils.dart';

final Util util = new Util();

class Lista extends StatelessWidget {
  const Lista({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Isolate Demo';

    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  Widget build(BuildContext context) {
    return bodyLista();
  }

  Future<dynamic> recuperarDados() async {

    String res = await ApiMonetizacao().pesquisarCotacao('Bitcoin', 2);
    var tagObjsJson = jsonDecode(res) as List;
    List lista = tagObjsJson;
    return lista;

  }

  Widget bodyLista() {
    return Scaffold(

      body: FutureBuilder(
        future: recuperarDados(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return Container(
              child: Center(
                child: Text(snapshot.data![10]['high']),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}