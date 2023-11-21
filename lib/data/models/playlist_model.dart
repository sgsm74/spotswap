import 'package:spotswap/data/models/track_model.dart';
import 'package:spotswap/domain/entities/playlist_entity.dart';

class PlayListModel extends PlayList {
  const PlayListModel({
    required super.id,
    required super.name,
    required super.tracks,
  });

  factory PlayListModel.fromJson(Map<String, dynamic> json) {
    return PlayListModel(
      id: json['id'],
      name: json['name'],
      tracks: json['tracks'].map((e) => TrackModel.fromJson(e)),
    );
  }
}
