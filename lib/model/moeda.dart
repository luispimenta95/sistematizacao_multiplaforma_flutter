
import 'package:intl/intl.dart';

class Moeda {

  final String nome;
  final String maiorCotacao;
  final String menorCotacao;
  final String dataCotacao;

  const Moeda({

    required this.nome,
    required this.maiorCotacao,
    required this.menorCotacao,
    required this.dataCotacao
  });

  factory Moeda.fromJson(Map<String, dynamic> json) {
    return Moeda(

      nome: json['name'] as String,
      maiorCotacao: json['high'] as String,
      menorCotacao: json['low'] as String,
      dataCotacao: json['timestamp'] as String

    );
  }
}