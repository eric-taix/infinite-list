import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inifinite_loading/infinite_list/bloc/infinite_list_cubit.dart';
import 'package:inifinite_loading/infinite_list/bloc/infinite_list_state.dart';
import 'package:inifinite_loading/lorem_filter.dart';
import 'package:inifinite_loading/main.dart';

class LoremHeader extends StatefulWidget {
  const LoremHeader({super.key});

  @override
  State<LoremHeader> createState() => _LoremHeaderState();
}

class _LoremHeaderState extends State<LoremHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: BlocBuilder<InfiniteListCubit<Lorem, LoremOptions>, InfiniteListState<Lorem, LoremOptions>>(
        builder: (BuildContext context, InfiniteListState<Lorem, LoremOptions> state) => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: const LoremFilter(),
            ),
            const Spacer(),
            SegmentedButton<SortType>(
              showSelectedIcon: false,
              onSelectionChanged: (Set<SortType> sortType) {
                final SortType currentSortType = sortType.first;
                context.read<InfiniteListCubit<Lorem, LoremOptions>>().load(
                      options: LoremOptions(
                        sortDirection: state.result.options.sortDirection,
                        sortType: currentSortType,
                        filter: state.result.options.filter,
                      ),
                    );
              },
              segments: const [
                ButtonSegment(label: Text('None'), value: SortType.none),
                ButtonSegment(label: Text('Title'), value: SortType.title),
                ButtonSegment(label: Text('Stars'), value: SortType.stars),
              ],
              selected: {state.result.options.sortType},
            ),
            const Spacer(),
            SegmentedButton<SortDirection>(
              showSelectedIcon: false,
              onSelectionChanged: (Set<SortDirection> sortDirection) {
                final SortDirection currentSortDirection = sortDirection.first;
                context.read<InfiniteListCubit<Lorem, LoremOptions>>().load(
                      options: LoremOptions(
                        sortDirection: currentSortDirection,
                        sortType: state.result.options.sortType,
                        filter: state.result.options.filter,
                      ),
                    );
              },
              segments: const [
                ButtonSegment(label: Icon(Icons.arrow_upward), value: SortDirection.asc),
                ButtonSegment(label: Icon(Icons.arrow_downward), value: SortDirection.desc),
              ],
              selected: {state.result.options.sortDirection},
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                context.read<InfiniteListCubit<Lorem, LoremOptions>>().load(
                      pageSize: 30,
                      options: LoremOptions(
                        sortDirection: SortDirection.asc,
                        sortType: SortType.none,
                        filter: null,
                      ),
                    );
              },
              child: const Text('Reload'),
            ),
          ],
        ),
      ),
    );
  }
}
