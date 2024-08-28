import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/{{paginate_name.snakeCase()}}_model.dart';

import '../riverpod/{{feature_name.snakeCase()}}_notifier.dart';
import '../riverpod/{{feature_name.snakeCase()}}_state.dart';
import '../riverpod/status/{{paginate_name.snakeCase()}}_list_status.dart';
import '{{paginate_name.snakeCase()}}_card.dart';
import 'empty_data_{{paginate_name.snakeCase()}}_list_widget.dart';
import 'loading_{{paginate_name.snakeCase()}}_card.dart';
import 'package:scroll_edge_listener/scroll_edge_listener.dart';


class {{paginate_name.pascalCase()}}ListWidget extends ConsumerStatefulWidget {
  const {{paginate_name.pascalCase()}}ListWidget({
    super.key,
  });

  @override
  ConsumerState<{{paginate_name.pascalCase()}}ListWidget> createState() => _{{paginate_name.pascalCase()}}ListWidgetState();
}

class _{{paginate_name.pascalCase()}}ListWidgetState extends ConsumerState<{{paginate_name.pascalCase()}}ListWidget> {
  final {{feature_name.snakeCase()}}Provider =
      StateNotifierProvider<{{feature_name.pascalCase()}}Notifier, {{feature_name.pascalCase()}}State>(
          (ref) => locator<{{feature_name.pascalCase()}}Notifier>());

  List<{{paginate_name.pascalCase()}}Model> list = [];

  bool isGrid = true;
  @override
  void initState() {
    super.initState();
    onWidgetCreated(context);
  }

  void onWidgetCreated(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshScreen();
    });
  }

  void refreshScreen() {
    callInitialEvent();
    callLoadEvent();
  }

  void callLoadEvent() {
    ref.read({{feature_name.snakeCase()}}Provider.notifier).get{{paginate_name.pascalCase()}}List(context: context);
  }

  void callInitialEvent() {
    ref.read({{feature_name.snakeCase()}}Provider.notifier).pageToInitial{{paginate_name.pascalCase()}}List();
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = Container();

    return Column(
      children: [
        createList(widget),
      ],
    );
  }

  createList(Widget shownWidget) {
    return Expanded(
      child: Consumer(
        builder: (context, _, __) {
          final state = ref.watch({{feature_name.snakeCase()}}Provider);

          bool isLoadingMore = false;
          if (state.{{paginate_name.snakeCase()}}ListStatus is {{paginate_name.pascalCase()}}ListLoading) {
            shownWidget = _createLoadingGridWidget();
          } else if (state.{{paginate_name.snakeCase()}}ListStatus is {{paginate_name.pascalCase()}}ListEmpty) {
            shownWidget = EmptyData{{paginate_name.pascalCase()}}ListWidget(
              onClickListener: () {
                refreshScreen();
              },
            );
          } else if (state.{{paginate_name.snakeCase()}}ListStatus is {{paginate_name.pascalCase()}}ListCompleted) {
            final {{paginate_name.pascalCase()}}ListCompleted completed =
                state.{{paginate_name.pascalCase()}}ListStatus as {{paginate_name.pascalCase()}}ListCompleted;
            list = completed.list;

            shownWidget = _createLoadedGridWidget(list, false);
          } else if (state.{{paginate_name.snakeCase()}}ListStatus is {{paginate_name.pascalCase()}}ListLoadingMore) {
            shownWidget = _createLoadedGridWidget(list, false);

            isLoadingMore = true;
          } else if (state.{{paginate_name.snakeCase()}}ListStatus is {{paginate_name.pascalCase()}}ListLoadedMoreError) {
            shownWidget = _createLoadedGridWidget(list, false);
          } else if (state.{{paginate_name.snakeCase()}}ListStatus is {{paginate_name.pascalCase()}}ListError) {
            {{paginate_name.pascalCase()}}ListError followingListError =
                state.{{paginate_name.pascalCase()}}ListStatus as {{paginate_name.pascalCase()}}ListError;
            shownWidget = _createErrorWidget(followingListError);
          }

          return Column(
            children: [
              Expanded(child: shownWidget),
              Visibility(
                visible: isLoadingMore,
                child: _createLoadMoreIndicator(),
              ),
            ],
          );
        },
      ),
    );
  }

  ErrorHandlingWidget _createErrorWidget({{paginate_name.pascalCase()}}ListError listError) {
    return ErrorHandlingWidget(
      listError.failure,
      onClickListener: () {
        refreshScreen();
      },
    );
  }

  _createLoadingGridWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GridView.builder(
          itemCount: 20,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const Loading{{paginate_name.pascalCase()}}Card();
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 165,
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
        ),
      );

  Widget _createLoadedGridWidget(List<{{paginate_name.pascalCase()}}Model> list, bool isLoading) {
    return ScrollEdgeListener(
      edge: ScrollEdge.end,
      edgeOffset: 30,
      continuous: false,
      debounce: const Duration(milliseconds: 500),
      dispatch: true,
      listener: () {
        if (isLoading) {
          return;
        }
        callLoadEvent();
      },
      child: RefreshIndicator(
        onRefresh: () async {
          refreshScreen();
        },
        backgroundColor: CustomColor.white,
        color: CustomColor.green,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 165,
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: list.length,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          itemBuilder: (context, index) {
            return FadeIn(
              duration: Duration(milliseconds: 500 + min(index * 100, 500)),
              child: InkWell(
                onTap: () {
                  context.pushNamed(RouteNames.product_list,
                      extra: list[index].toJson());
                },
                child: {{paginate_name.pascalCase()}}Card(
                  {{paginate_name.snakeCase()}}Model: list[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _createLoadMoreIndicator() {
    return const CircularProgressIndicator(
      color: CustomColor.green,
    );
  }
}
