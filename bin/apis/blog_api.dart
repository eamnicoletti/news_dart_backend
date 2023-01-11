import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/noticia_model.dart';
import '../services/generic_service.dart';
import '../services/noticia_service.dart';

class BlogApi {
  final GenericService<NoticiaModel> _service;

  BlogApi(this._service);

  Handler get handler {
    Router router = Router();

    // listagem
    router.get('/blog/noticias', (Request req) {
      List<NoticiaModel> noticias = _service.findAll();
      List<Map> noticiasMap = noticias.map((e) => e.toJson()).toList();

      return Response.ok(jsonEncode(noticiasMap));
    });

    // nova noticia
    router.post('/blog/noticias', (Request req) async {
      var body = await req.readAsString();
      _service.save(NoticiaModel.fromJson(jsonDecode(body)));

      return Response(201);
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
