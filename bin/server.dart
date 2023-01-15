import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service_imp.dart';
import 'services/noticia_service.dart';
import 'utils/custom_env.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main() async {
  CustomEnv.fromFile('.env-dev');

  var securityService = SecurityServiceImp();

  var cascateHandler = Cascade()
      .add(
        LoginApi(SecurityServiceImp()).getHandler(),
      )
      .add(
        BlogApi(NoticiaService()).getHandler(middlewares: [
          securityService.authorization,
          securityService.verifyJWT,
        ]),
      )
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
