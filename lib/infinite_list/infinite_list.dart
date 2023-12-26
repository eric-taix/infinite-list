import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inifinite_loading/infinite_list/bloc/infinite_list_cubit.dart';
import 'package:inifinite_loading/infinite_list/bloc/infinite_list_state.dart';
import 'package:inifinite_loading/infinite_list/view_models/page_result.dart';

typedef InfiniteListBuilder<T, O> = Widget Function(BuildContext context, T item);
typedef InfiniteListLoadingBuilder = Widget Function(BuildContext context);
typedef HeaderBuilder = Widget Function(BuildContext context);

class InfiniteList<T, O> extends StatefulWidget {
  const InfiniteList({
    required this.fetcher,
    required this.loadingBuilder,
    required this.itemBuilder,
    this.headerBuilder,
    required this.initialOptions,
    super.key,
  });

  final O initialOptions;
  final InfiniteListFetcher<T, O> fetcher;
  final HeaderBuilder? headerBuilder;
  final InfiniteListBuilder<T, O> itemBuilder;
  final InfiniteListLoadingBuilder loadingBuilder;

  @override
  State<InfiniteList<T, O>> createState() => _InfiniteListState<T, O>();
}

class _InfiniteListState<T, O> extends State<InfiniteList<T, O>> {
  late final InfiniteListCubit<T, O> _infiniteListCubit;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _infiniteListCubit = InfiniteListCubit<T, O>(fetcher: widget.fetcher, initialOptions: widget.initialOptions)
      ..load();
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
          _infiniteListCubit.next();
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _infiniteListCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _infiniteListCubit,
      child: BlocConsumer<InfiniteListCubit<T, O>, InfiniteListState<T, O>>(
        bloc: _infiniteListCubit,
        listener: (BuildContext context, InfiniteListState<T, O> state) {
          if (state is InfiniteLoaderInitial) {
            _scrollController.jumpTo(0);
          }
        },
        builder: (BuildContext context, InfiniteListState<T, O> state) {
          return Column(
            children: [
              widget.headerBuilder?.call(context) ?? const SizedBox.shrink(),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) => index < state.result.data.length
                      ? widget.itemBuilder(context, state.result.data[index])
                      : widget.loadingBuilder(context),
                  itemCount: switch (state) {
                    InfiniteLoaderInitial<T, O>() => 0,
                    InfiniteLoaderLoading<T, O>(:final int itemCount) => itemCount,
                    InfiniteLoaderUpdated<T, O>(:final PageResult<T, O> result) => result.data.length,
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
