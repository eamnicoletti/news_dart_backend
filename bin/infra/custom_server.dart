import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class CustomServer {
  Future<void> initialize({
    required Handler handler,
    required String address,
    required int port,
  }) async {
    // Use any available host or container IP (usually `0.0.0.0`).
    await shelf_io.serve(handler, address, port);
    print('Server listening on -> http://$address:$port');
  }
}
