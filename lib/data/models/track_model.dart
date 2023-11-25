import 'package:spotswap/domain/entities/track_entity.dart';

class TrackModel extends Track {
  const TrackModel({
    required super.id,
    required super.uri,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      id: json['track']['id'],
      uri: json['track']['uri'],
    );
  }

  toJson() => {'id': id, 'uri': uri};
}
