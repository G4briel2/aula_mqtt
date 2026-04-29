class Cliente {
  final String nome ;
  final String endereco ;
  final String cidade;
  final String nascimento;

  @override
  String toString() {
    return 'Cliente{nome: $nome, endereco: $endereco, cidade: $cidade, nascimento: $nascimento}';
  }

  const Cliente(
  {
    required this.nome,
    required this.endereco,
    required this.cidade,
    required this.nascimento
  });

  Map<String, dynamic> toMap(){
    return {
      'nome': nome,
      'endereco': endereco,
      'cidade': cidade,
      'nascimento': nascimento
    };
  }

}



