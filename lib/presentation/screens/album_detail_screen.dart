import 'package:flutter/material.dart';
import '../../data/models/album_model.dart';
import '../../data/models/photo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/blocs/album/album_bloc.dart';
import '../../domain/blocs/album/album_state.dart';

class AlbumDetailScreen extends StatefulWidget {
  final int albumId;

  const AlbumDetailScreen({super.key, required this.albumId});

  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Album #${widget.albumId}')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoaded) {
            final album = state.albums.firstWhere((a) => a.id == widget.albumId);
            final photos = state.photos.where((p) => p.albumId == widget.albumId).toList();

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${album.title}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('Photos:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: photos.length,
                      itemBuilder: (context, index) {
                        final photo = photos[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 4,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    photo.thumbnailUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                photo.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
