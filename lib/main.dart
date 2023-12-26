import 'package:flutter/material.dart';
import 'package:inifinite_loading/infinite_list/infinite_list.dart';
import 'package:inifinite_loading/load_lorem_use_case.dart';
import 'package:inifinite_loading/loading_lorem_card.dart';
import 'package:inifinite_loading/lorem_card.dart';
import 'package:inifinite_loading/lorem_header.dart';

class Lorem {
  final int id;
  final String title;
  final String paragraph;
  final int stars;

  Lorem({required this.id, required this.title, required this.paragraph, required this.stars});
}

enum SortDirection { asc, desc }

enum SortType { none, title, stars }

class LoremOptions {
  final SortDirection sortDirection;
  final SortType sortType;
  final String? filter;
  LoremOptions({required this.sortDirection, required this.sortType, this.filter});

  @override
  String toString() {
    return 'LoremOptions{sortDirection: $sortDirection, sortType: $sortType}';
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Infinite List Demo Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: InfiniteList<Lorem, LoremOptions>(
        initialOptions: LoremOptions(sortDirection: SortDirection.asc, sortType: SortType.none),
        fetcher: LoadLoremUseCase(),
        headerBuilder: (BuildContext context) => const LoremHeader(),
        itemBuilder: (BuildContext context, Lorem item) => LoremCard(key: ValueKey(item.id), lorem: item),
        loadingBuilder: (BuildContext context) => const LoadingLoremCard(),
      ),
    );
  }
}
