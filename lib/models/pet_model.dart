class Pet {
  String nome;
  String imageUrl;
  String descricao;
  int idade;
  String sexo;
  String cor;
  String bio;
  int id;

  Pet({
    this.nome,
    this.imageUrl,
    this.descricao,
    this.idade,
    this.sexo,
    this.cor,
    this.bio,
    this.id
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'imageUrl': 'assets/images/toto.png',
      'descricao': descricao,
      'idade': idade,
      'sexo': sexo,
      'cor': cor,
      'bio': bio
    };
  }

  Pet.fromMap(Map map) {
    id= map['id'];
    nome= map['nome'];
    imageUrl= map['imageUrl'];
    descricao= map['descricao'];
    idade= map['idade'];
    cor= map['cor'];
    sexo= map['sexo'];
    bio= map['bio'];
  }
}