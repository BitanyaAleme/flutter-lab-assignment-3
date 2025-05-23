import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/repositories/album_repository.dart';
import 'domain/blocs/album/album_bloc.dart';
import 'domain/blocs/album/album_event.dart';
import 'routes/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AlbumRepository repository = AlbumRepository(httpClient: http.Client());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlbumBloc(repository: repository)..add(LoadAlbums()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        title: 'Albums App',
      ),
    );
  }
}
