import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inifinite_loading/infinite_list/bloc/infinite_list_cubit.dart';
import 'package:inifinite_loading/infinite_list/bloc/infinite_list_state.dart';
import 'package:inifinite_loading/main.dart';

class LoremFilter extends StatefulWidget {
  const LoremFilter({super.key});

  @override
  State<LoremFilter> createState() => _LoremFilterState();
}

class _LoremFilterState extends State<LoremFilter> {
  late final TextEditingController _textEditingController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfiniteListCubit<Lorem, LoremOptions>, InfiniteListState<Lorem, LoremOptions>>(
      builder: (BuildContext context, InfiniteListState<Lorem, LoremOptions> state) {
        return TextField(
          controller: _textEditingController,
          onChanged: (String filterText) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(
              const Duration(milliseconds: 500),
              () {
                context.read<InfiniteListCubit<Lorem, LoremOptions>>().load(
                      options: LoremOptions(
                        filter: filterText,
                        sortDirection: state.result.options.sortDirection,
                        sortType: state.result.options.sortType,
                      ),
                    );
              },
            );
          },
        );
      },
      listener: (BuildContext context, InfiniteListState<Lorem, LoremOptions> state) {
        _textEditingController.text = state.result.options.filter ?? '';
      },
    );
  }
}
