class PaginationDataModel<T> {
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
    for (var item in json['items']) {
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
}
