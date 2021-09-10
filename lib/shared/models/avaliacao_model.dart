class AvaliacaoModel {
  int? id;
  String? criado;
  String? modificado;
  double? nota;
  String? descricao;
  int? passeioId;

  AvaliacaoModel({
    this.id,
    this.criado,
    this.modificado,
    this.nota,
    this.descricao,
    this.passeioId,
  });

  AvaliacaoModel copyWith({
    int? id,
    String? criado,
    String? modificado,
    double? nota,
    String? descricao,
    int? passeioId,
  }) {
    return AvaliacaoModel(
      id: id ?? this.id,
      criado: criado ?? this.criado,
      modificado: modificado ?? this.modificado,
      nota: nota ?? this.nota,
      descricao: descricao ?? this.descricao,
      passeioId: passeioId ?? this.passeioId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'criado': criado,
      'modificado': modificado,
      'nota': nota,
      'descricao': descricao,
      'passeioId': passeioId,
    };
  }

  factory AvaliacaoModel.fromMap(Map<String, dynamic> map) {
    return AvaliacaoModel(
      id: map['id'],
      criado: map['criado'],
      modificado: map['modificado'],
      nota: map['nota'],
      descricao: map['descricao'],
      passeioId: map['passeioId'],
    );
  }

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

  @override
  String toString() {
    return 'AvaliacaoModel(id: $id, criado: $criado, modificado: $modificado, nota: $nota, descricao: $descricao, passeioId: $passeioId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AvaliacaoModel &&
        other.id == id &&
        other.criado == criado &&
        other.modificado == modificado &&
        other.nota == nota &&
        other.descricao == descricao &&
        other.passeioId == passeioId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        criado.hashCode ^
        modificado.hashCode ^
        nota.hashCode ^
        descricao.hashCode ^
        passeioId.hashCode;
  }
}
