class PageResult<T, O> {
  final List<T> data;
  final int total;
  final int page;
  final int size;

  final O options;

  PageResult({
    required this.data,
    required this.total,
    required this.page,
    required this.size,
    required this.options,
  });
}
