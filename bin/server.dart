import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'dao/usuario_dao.dart';
import 'infra/custom_server.dart';
import 'infra/database/db_configuration.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'models/usuario_model.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  final _di = Injects.initialize();

  var conexao = await _di.get<DBConfiguration>().connection;
  UsuarioDAO _usuarioDAO = UsuarioDAO(_di.get<DBConfiguration>());

  var usuario = UsuarioModel()
    ..id = 5
    ..name = 'Novo Usuario'
    ..email = 'xpto@gmaeil.com'
    ..password = '123';

  // _usuarioDAO.findAll().then(print);
  // _usuarioDAO.findOne(1).then(print);
  // _usuarioDAO.create(usuario).then(print);
  // usuario.name = 'ATUALIZADO';
  // _usuarioDAO.update(usuario).then(print);
  // _usuarioDAO.delete(5).then(print);

  var cascateHandler = Cascade()
      .add(_di.get<LoginApi>().getHandler())
      .add(_di.get<BlogApi>().getHandler(isSecurity: true))
      .handler;

  final handler = Pipeline()
      .addMiddleware(logRequests()) // global Middlewares
      .addMiddleware(MiddlewareInterception().middleware) // global Middlewares
      .addHandler(cascateHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
