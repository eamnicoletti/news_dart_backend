import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../services/generic_service.dart';
import '../services/noticia_service.dart';

class BlogApi {
  final GenericService _service;

  BlogApi(this._service);

  Handler get handler {
    Router router = Router();

    // listagem
    router.get('/blog/noticias', (Request req) {
      // _service.findAll();
      return Response.ok('Choveu hoje');
    });

    // nova noticia
    router.post('/blog/noticias', (Request req) {
      // _service.save(value);
      return Response.ok('Choveu hoje');
    });

    // /blog/noticias?id=1 // update
    router.put('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      // _service.save(value);
      return Response.ok('Choveu hoje');
    });

    // /blog/noticias?id=1 // delete
    router.delete('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      // _service.delete(id);
      return Response.ok('Choveu hoje');
    });

    return router;
  }
}
