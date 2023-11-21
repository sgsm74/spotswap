import 'package:equatable/equatable.dart';
import 'package:spotswap/domain/entities/track_entity.dart';

class PlayList extends Equatable {
  const PlayList({
    required this.id,
    required this.name,
    required this.tracks,
  });

  final String id;
  final String name;
  final List<Track> tracks;

  @override
  List<Object> get props => [id];
}
