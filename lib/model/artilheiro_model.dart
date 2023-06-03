class Artilheiro {
  final int gols;
  final String nomeJogador;

  Artilheiro({
    required this.gols,
    required this.nomeJogador,
  });

  factory Artilheiro.fromJson(Map<String, dynamic> map) {
    return Artilheiro(
      gols: map['gols'],
      nomeJogador: map['atleta']['nome_popular'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gols': gols,
      'atleta': {'nome_popular': nomeJogador},
    };
  }
}
