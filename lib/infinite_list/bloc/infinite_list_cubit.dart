import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inifinite_loading/infinite_list/bloc/infinite_list_state.dart';
import 'package:inifinite_loading/infinite_list/view_models/page_request.dart';
import 'package:inifinite_loading/infinite_list/view_models/page_result.dart';

typedef InfiniteListFetcher<T, O> = Future<PageResult<T, O>> Function(PageRequest<T, O> pagerRequest);

class InfiniteListCubit<T, O> extends Cubit<InfiniteListState<T, O>> {
  InfiniteListCubit({required this.fetcher, required O initialOptions}) : super(InfiniteLoaderInitial(initialOptions));

  final InfiniteListFetcher<T, O> fetcher;

  void load({O? options, int pageSize = 10}) async {
    emit(InfiniteLoaderInitial(state.result.options));
    _loadPage(
      itemCount: pageSize,
      request: PageRequest(
        page: 0,
        size: pageSize,
        options: options ?? state.result.options,
      ),
    );
  }

  _loadPage({required int itemCount, required PageRequest<T, O> request}) async {
    emit(
      InfiniteLoaderLoading(
        itemCount: itemCount,
        result: PageResult<T, O>(
          data: state.result.data,
          total: state.result.total,
          page: request.page,
          size: request.size,
          options: request.options ?? state.result.options,
        ),
      ),
    );
    final pageResult = await fetcher.call(request);
    emit(
      InfiniteLoaderUpdated(
        result: PageResult<T, O>(
          data: [...state.result.data, ...pageResult.data],
          total: pageResult.total,
          page: pageResult.page,
          size: pageResult.size,
          options: state.result.options,
        ),
      ),
    );
  }

  Future<void> next() async {
    final result = state.result;
    if ((result.page + 1) * result.size < result.total) {
      _loadPage(
          itemCount: result.data.length + result.size,
          request: PageRequest(
            page: result.page + 1,
            size: result.size,
            options: state.result.options,
          ));
    }
  }
}
