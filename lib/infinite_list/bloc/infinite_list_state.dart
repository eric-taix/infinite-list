import 'package:flutter/material.dart';
import 'package:inifinite_loading/infinite_list/view_models/page_result.dart';

@immutable
sealed class InfiniteListState<T, O> {
  final PageResult<T, O> result;

  const InfiniteListState({required this.result});
}

class InfiniteLoaderInitial<T, O> extends InfiniteListState<T, O> {
  InfiniteLoaderInitial(O initialOptions)
      : super(
          result: PageResult<T, O>(
            data: [],
            total: 0,
            page: 0,
            size: 0,
            options: initialOptions,
          ),
        );
}

class InfiniteLoaderLoading<T, O> extends InfiniteListState<T, O> {
  const InfiniteLoaderLoading({required this.itemCount, required super.result});

  final int itemCount;
}

class InfiniteLoaderUpdated<T, O> extends InfiniteListState<T, O> {
  const InfiniteLoaderUpdated({required super.result});
}
