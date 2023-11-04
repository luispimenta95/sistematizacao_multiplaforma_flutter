

import 'package:sistematizacao_dmm/controller/utils.dart';

import 'dart:convert' as convert;

class ApiMonetizacao{

  String maiorCotacao = '';
  String menorCotacao = '';
  String name = '';
  bool isLoading = true;
  final Util util = new Util();
  final coinsOptions = {
    "Dirham dos Emirados": "AED",
    "Bitcoin": "BTC",
    "Dólar Americano": "USD",
    "Dólar Canadense": "CAD",
    "teste erro": "err"
  };
  static const String pais = 'BRL';


String response ='';
  Future<String> pesquisarCotacao(String query,int tipo) async {
    String url = '';
    String? moeda = coinsOptions[query];
    if (tipo == 1) {
      url = 'http://economia.awesomeapi.com.br/json/last/$moeda-$pais';
    } else {
      url = 'https://economia.awesomeapi.com.br/json/daily/$moeda-$pais/15';
    }

     response = await util.makeRequest(url);
    if(tipo ==1) {
      var jsonResponse = convert.jsonDecode(response) as Map<String, dynamic>;
      if (jsonResponse['status'] != 404) {
        name = jsonResponse['$moeda$pais']['name'];
        maiorCotacao = util.formatarMoeda(jsonResponse['$moeda$pais']['high']);
        menorCotacao = util.formatarMoeda(jsonResponse['$moeda$pais']['low']);
      }
    }
      return response;
  }

  List<String> sugestoesPesquisa(){
    return
    [
      'Bitcoin',
      'Dirham dos Emirados',
     'Dólar Americano',
      'Dólar Canadense',
      'teste erro'

    ];
  }

}