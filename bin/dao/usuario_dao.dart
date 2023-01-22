import '../infra/database/db_configuration.dart';
import '../models/usuario_model.dart';
import 'dao.dart';

class UsuarioDao implements Dao {
  final DBConfiguration _dbConfiguration;
  UsuarioDao(this._dbConfiguration);
  @override
  Future create(value) async {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future delete(int id) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<UsuarioModel>> findAll() async {
    final String SQL = 'SELECT * FROM usuarios';
    var connection = await _dbConfiguration.connection;
    var result = await connection.query(SQL);
    List<UsuarioModel> _usuarios = [];
    for (var r in result) {
      _usuarios.add(UsuarioModel.fromMap(r.fields));
    }
    return _usuarios;
  }

  @override
  Future<UsuarioModel> findOne(int id) async {
    final String SQL = 'SELECT * FROM usuarios WHERE id = ?';
    var connection = await _dbConfiguration.connection;
    var result = await connection.query(SQL, [id]);
    if (result.isEmpty) {
      throw Exception('[ERROR/DB] -> findOne for id: $id, Not Found');
    }
    return UsuarioModel.fromMap(result.first.fields);
  }

  @override
  Future update(value) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
