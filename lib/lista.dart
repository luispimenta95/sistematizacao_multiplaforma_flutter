import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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

  final String dataCotacao;
  final String maiorCotacao;
  final String menorCotacao;


  const Moeda({

    required this.dataCotacao,
    required this.maiorCotacao,
    required this.menorCotacao
  });

  factory Moeda.fromJson(Map<String, dynamic> json) {


    return Moeda(



        dataCotacao: json['timestamp'] as String,
        maiorCotacao: json['high'] as String,
        menorCotacao: json['low'] as String
    );
  }


}



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
                // _criarLinhaTable("Dia, Alta, Baixa"),

                for(var item in photos)
                  _criarLinhas(item),
              ],
            )
          ],
        ),
      );
  }
  _criarLinhas(Moeda dados) {
    String dataAjustada = formatarData(dados.dataCotacao);
    String high = formatarMoeda(dados.maiorCotacao);
    String low = formatarMoeda(dados.menorCotacao);



    return TableRow(

        children: [
          Text(dataAjustada),
          Text(high),
          Text(low),
        ]
    );
  }

  String formatarData(String dataCotacao) {
    int intVal = int.parse(dataCotacao);
    final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(intVal * 1000);
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(date1);
    return outputDate;
  }

  String formatarMoeda(valor) {
    double value = double.parse(valor);
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    String newText = "R\$ " + formatter.format(value);

    return newText;
  }
}