import 'package:equatable/equatable.dart';
import '../../../data/models/album_model.dart';
import '../../../data/models/photo_model.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  final List<Photo> photos;

  const AlbumLoaded({required this.albums, required this.photos});

  @override
  List<Object> get props => [albums, photos];
}

class AlbumError extends AlbumState {
  final String message;

  const AlbumError(this.message);

  @override
  List<Object> get props => [message];
}
