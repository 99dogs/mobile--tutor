class AvaliacaoModel {
  int? id;
  String? criado;
  String? modificado;
  double? nota;
  String? descricao;
  int? passeioId;

  AvaliacaoModel({
    required this.id,
    required this.criado,
    required this.modificado,
    required this.nota,
    required this.descricao,
    required this.passeioId,
  });

  AvaliacaoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    criado = json['criado'];
    modificado = json['modificado'];
    nota = json['nota'];
    descricao = json['descricao'];
    passeioId = json['passeioId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['criado'] = this.criado;
    data['modificado'] = this.modificado;
    data['nota'] = this.nota;
    data['descricao'] = this.descricao;
    data['passeioId'] = this.passeioId;
    return data;
  }
}
