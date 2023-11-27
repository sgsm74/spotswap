import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'track_entity.g.dart';

@HiveType(typeId: 1)
class Track extends Equatable {
  const Track({
    required this.id,
    required this.uri,
  });
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String uri;

  @override
  List<Object> get props => [id];
}
