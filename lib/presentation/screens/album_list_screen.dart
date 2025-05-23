import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/album_model.dart';
import '../../data/models/photo_model.dart';
import '../../domain/blocs/album/album_bloc.dart';
import '../../domain/blocs/album/album_state.dart';
import '../../domain/blocs/album/album_event.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AlbumBloc>().add(LoadAlbums());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is AlbumLoaded) {
            final List<Album> albums = state.albums;
            final List<Photo> photos = state.photos;

            return GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: albums.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final album = albums[index];
                final photo = photos.firstWhere(
                      (photo) => photo.albumId == album.id,
                  orElse: () => Photo(
                    albumId: album.id,
                    title: '',
                    url: '',
                    thumbnailUrl: '',
                  ),
                );

                return GestureDetector(
                  onTap: () {
                    context.push('/album/${album.id}');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        photo.thumbnailUrl.isNotEmpty
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            photo.thumbnailUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        )
                            : const Icon(Icons.photo, size: 60),
                        const SizedBox(height: 10),
                        Text(
                          album.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
