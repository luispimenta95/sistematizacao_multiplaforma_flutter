import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Moeda>> recuperarDados(http.Client client) async {
  String url = 'https://economia.awesomeapi.com.br/json/daily/USD-BRL/15';
  final response = await client
      .get(Uri.parse(url));
  // Use the compute function to run tratarResposta in a separate isolate.
  return compute(tratarResposta, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Moeda> tratarResposta(String responseBody) {
  final parsed =
  (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<Moeda>((json) => Moeda.fromJson(json)).toList();
}

class Moeda {

  final String nome;
  final String maiorCotacao;
  final String menorCotacao;


  const Moeda({

    required this.nome,
    required this.maiorCotacao,
    required this.menorCotacao
  });

  factory Moeda.fromJson(Map<String, dynamic> json) {


    return Moeda(



      nome: json['timestamp'] as String,
      maiorCotacao: json['high'] as String,
      menorCotacao: json['low'] as String
    );
  }


}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Moeda>>(
        future: recuperarDados(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
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

class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});

  final List<Moeda> photos;

  @override
  Widget build(BuildContext context) {
    return createBody();
  }

  Widget createBody() {

    return
      Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Table(

              children: <TableRow>[
                _criarLinhaTable("Dia, Alta, Baixa"),

                for(var item in photos)
                _criarLinhaTable(""+item.nome +", "+item.menorCotacao +"," +item.menorCotacao),
              ],
            )
          ],
        ),
      );
  }
  _criarLinhaTable(String listaNomes) {
    return TableRow(
      children: listaNomes.split(',').map((name) {
        return Container(
          alignment: Alignment.center,
          child: Text(
            name,
            style: TextStyle(fontSize: 20.0),
          ),
          padding: EdgeInsets.all(8.0),
        );
      }).toList(),
    );
  }
}