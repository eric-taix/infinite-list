import 'dart:math';

import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:inifinite_loading/infinite_list/view_models/page_request.dart';
import 'package:inifinite_loading/infinite_list/view_models/page_result.dart';
import 'package:inifinite_loading/main.dart';

const int fakeTotalItems = 200;

final List<Lorem> fakeLorems = List.generate(
  fakeTotalItems,
  (int index) => Lorem(
    id: index,
    title: 'Section ${index + 1}',
    paragraph: lorem(paragraphs: 2, words: 60),
    stars: Random().nextInt(5) + 1,
  ),
);

class LoadLoremUseCase {
  int _directionSign(LoremOptions? options) => (options?.sortDirection == SortDirection.asc ? 1 : -1);

  Future<PageResult<Lorem, LoremOptions>> call(PageRequest<Lorem, LoremOptions> request) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final List<Lorem> sortedLorem =
        fakeLorems.where((Lorem lorem) => lorem.title.contains(request.options.filter ?? '')).toList(growable: false)
          ..sort(switch (request.options.sortType) {
            SortType.none => (Lorem a, Lorem b) => a.id.compareTo(b.id) * _directionSign(request.options),
            SortType.title => (Lorem a, Lorem b) => a.title.compareTo(b.title) * _directionSign(request.options),
            SortType.stars => (Lorem a, Lorem b) => a.stars.compareTo(b.stars) * _directionSign(request.options),
          });

    final int start = request.page * request.size;
    final int end = ((request.page + 1) * request.size).clamp(0, sortedLorem.length);
    return start < sortedLorem.length
        ? PageResult<Lorem, LoremOptions>(
            data: sortedLorem.sublist(start, end),
            total: sortedLorem.length,
            page: request.page,
            size: request.size,
            options: request.options,
          )
        : PageResult<Lorem, LoremOptions>(
            data: sortedLorem.sublist(start, end),
            total: sortedLorem.length,
            page: request.page,
            size: request.size,
            options: request.options,
          );
  }
}
