import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Util{


  String formatarMoeda(valor) {
    double value = double.parse(valor);
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    String newText = "R\$ " + formatter.format(value);

    return newText;
  }
  Future<String> makeRequest(String url) async {

    final response = await http.get(Uri.parse(url));

      return  response.body;
  }

  String formatarData(String dataCotacao) {
    int intVal = int.parse(dataCotacao);
    final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(intVal * 1000);
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(date1);
    return outputDate;
  }


}