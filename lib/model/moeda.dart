
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

      nome: json['name'] as String,
      maiorCotacao: json['high'] as String,
      menorCotacao: json['low'] as String,

    );
  }
}