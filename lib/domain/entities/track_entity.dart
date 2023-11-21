import 'package:equatable/equatable.dart';

class Track extends Equatable {
  const Track({
    required this.id,
    required this.uri,
  });

  final String id;
  final String uri;

  @override
  List<Object> get props => [id];
}
