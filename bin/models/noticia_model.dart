// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoticiaModel {
  int? id;
  String? title;
  String? description;
  DateTime? dtCreated;
  DateTime? dtUpdated;
  int? userId;

  NoticiaModel();

  @override
  String toString() {
    return 'NoticiaModel(id: $id, title: $title, description: $description, dtCreated: $dtCreated, dtUpdated: $dtUpdated, userId: $userId)';
  }
}
