import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middlewares});

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
  }) {
    middlewares ??= [];
    var pipeline = Pipeline();

    for (var m in middlewares) {
      pipeline = pipeline.addMiddleware(m);
    }

    return pipeline.addHandler(router);
  }
}
