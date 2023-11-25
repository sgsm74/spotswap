import 'package:equatable/equatable.dart';

class PaginationDataModel<T> extends Equatable {
  const PaginationDataModel({
    required this.items,
    required this.limit,
    required this.offset,
    required this.total,
    required this.next,
    required this.previous,
  });

  factory PaginationDataModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJson,
  ) {
    List<T> items = [];
    for (final item in json['items']) {
      items.add(fromJson(item));
    }
    return PaginationDataModel(
      items: items,
      limit: json['limit'],
      offset: json['offset'],
      total: json['total'],
      next: json['next'],
      previous: json['previous'],
    );
  }

  final List<T> items;
  final int limit;
  final int offset;
  final int total;
  final String? next;
  final String? previous;

  @override
  List<Object> get props => [items];
}
