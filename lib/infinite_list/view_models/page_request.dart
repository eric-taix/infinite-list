class PageRequest<T, O> {
  final int page;
  final int size;
  final O options;

  PageRequest({
    required this.options,
    this.page = 1,
    this.size = 10,
  });
}
