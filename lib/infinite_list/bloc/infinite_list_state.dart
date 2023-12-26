import 'package:flutter/material.dart';
import 'package:inifinite_loading/infinite_list/view_models/page_result.dart';

@immutable
sealed class InfiniteListState<T, O> {
  final PageResult<T, O> result;

  const InfiniteListState({required this.result});
}

class InfiniteListInitial<T, O> extends InfiniteListState<T, O> {
  InfiniteListInitial(O initialOptions)
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

class InfiniteListLoading<T, O> extends InfiniteListState<T, O> {
  const InfiniteListLoading({required this.itemCount, required super.result});

  final int itemCount;
}

class InfiniteListUpdated<T, O> extends InfiniteListState<T, O> {
  const InfiniteListUpdated({required super.result});
}

class InfiniteListError<T, O> extends InfiniteListState<T, O> {
  const InfiniteListError({required super.result});
}
