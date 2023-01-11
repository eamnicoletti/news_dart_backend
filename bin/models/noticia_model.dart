import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoticiaModel {
  final int? id;
  final String titulo;
  final String descricao;
  final String imagem;
  final DateTime dtPublicacao;
  final DateTime? dtAtulizacao;

  NoticiaModel({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.imagem,
    required this.dtPublicacao,
    this.dtAtulizacao,
  });

  @override
  String toString() {
    return 'NoticiaModel(id: $id, titulo: $titulo, descricao: $descricao, imagem: $imagem, dtPublicacao: $dtPublicacao, dtAtulizacao: $dtAtulizacao)';
  }

  factory NoticiaModel.fromJson(Map map) {
    return NoticiaModel(
      id: map['id'] ?? '',
      titulo: map['titulo'],
      descricao: map['descricao'],
      imagem: map['imagem'],
      dtPublicacao: DateTime.fromMicrosecondsSinceEpoch(map['dtPublicacao']),
      dtAtulizacao: map['dtAtulizacao'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(map['dtAtulizacao'])
          : null,
    );
  }

  Map toJson() {
    return {
      "id": id,
      "titulo": titulo,
      "descricao": descricao,
      "imagem": imagem,
    };
  }
}
