class Tabela {
  final int posicao;
  final int pontos;
  final String nomeTime;

  Tabela({
    required this.posicao,
    required this.pontos,
    required this.nomeTime,
  });

  factory Tabela.fromJson(Map<String, dynamic> map) {
    return Tabela(
      posicao: map['posicao'],
      pontos: map['pontos'],
      nomeTime: map['time']['nome_popular'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'posicao': posicao,
      'pontos': pontos,
      'time': {'nome_popular': nomeTime},
    };
  }
}
