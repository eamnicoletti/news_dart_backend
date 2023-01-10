// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoticiaModel {
  final int id;
  final String titulo;
  final String descricao;
  final String imagem;
  final DateTime dtPublicacao;
  final DateTime? dtAtulizacao;

  NoticiaModel({
    required this.id,
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
}
