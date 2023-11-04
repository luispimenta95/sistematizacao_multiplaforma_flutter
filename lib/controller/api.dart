

import 'package:sistematizacao_dmm/controller/utils.dart';


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



  Future<String> pesquisarApi(String query) async {
    String? moeda = coinsOptions[query];
    String url = 'http://economia.awesomeapi.com.br/json/last/$moeda-$pais';


    final response = await util.makeRequest(url);
    if (response['status'] != 404) {

      name = response['$moeda$pais']['name'];
      maiorCotacao = util.formatarMoeda(response['$moeda$pais']['high']);
      menorCotacao = util.formatarMoeda(response['$moeda$pais']['low']);
      return 'Ok';
    } else {
      return 'Erro';
    }
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