import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/album_list_screen.dart';
import '../presentation/screens/album_detail_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'albums',
      builder: (context, state) => AlbumListScreen(),
    ),
    GoRoute(
      path: '/album/:id',
      name: 'albumDetail',
      builder: (context, state) {
        final albumId = int.parse(state.pathParameters['id']!);
        return AlbumDetailScreen(albumId: albumId);
      },
    ),
  ],
);
