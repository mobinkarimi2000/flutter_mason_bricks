import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/custom_colors.dart';
import '../../../../core/widget/error_handling/error_handling_widget.dart';
import '../../domain/models/{{paginate_name.snackCase()}}_model.dart';
import '../bloc/{{feature_name.pascalCase()}}_bloc.dart';
import '../bloc/status/{{paginate_name.snackCase()}}_list_status.dart';
import 'empty_data_{{paginate_name.snackCase()}}_list_widget.dart';
import 'loading_{{paginate_name.snackCase()}}_card.dart';
import '{{paginate_name.snackCase()}}_card.dart';
import 'package:scroll_edge_listener/scroll_edge_listener.dart';

class {{paginate_name.pascalCase()}}ListWidget extends StatefulWidget {
  const {{paginate_name.pascalCase()}}ListWidget({
    super.key,
    required this.type,
  });
  final int type;
  @override
  State<{{paginate_name.pascalCase()}}ListWidget> createState() => _{{paginate_name.pascalCase()}}ListWidgetState();
}

class _{{paginate_name.pascalCase()}}ListWidgetState extends State<{{paginate_name.pascalCase()}}ListWidget> {
  late {{feature_name.pascalCase()}}Bloc {{paginate_name.snackCase()}}Bloc;

  List<{{paginate_name.pascalCase()}}Model> list = [];
  @override
  void initState() {
    super.initState();
    onWidgetCreated(context);
  }

  void onWidgetCreated(BuildContext context) {
    {{paginate_name.snackCase()}}Bloc = BlocProvider.of<{{feature_name.pascalCase()}}Bloc>(context);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshScreen();
    });
  }

  void refreshScreen() {
    callInitialEvent();
    callLoadEvent();
  }

  void callLoadEvent() {
    {{paginate_name.snackCase()}}Bloc.add(Get{{paginate_name.pascalCase()}}ListEvent());
  }

  void callInitialEvent() {
    {{paginate_name.snackCase()}}Bloc.add(PageToInitial{{paginate_name.pascalCase()}}ListEvent());
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

  Expanded createList(Widget widget) {
    return Expanded(
      child: BlocBuilder<{{feature_name.pascalCase()}}Bloc, {{feature_name.pascalCase()}}State>(
        builder: (context, state) {
          bool isLoadingMore = false;
          if (state.{{paginate_name.snackCase()}}ListStatus is {{paginate_name.pascalCase()}}ListLoading) {
            widget = _createLoadingWidget();
          } else if (state.{{paginate_name.snackCase()}}ListStatus is {{paginate_name.pascalCase()}}ListEmpty) {
            widget = EmptyData{{paginate_name.pascalCase()}}ListWidget(
              onClickListener: () {
                refreshScreen();
              },
            );
          } else if (state.{{paginate_name.snackCase()}}ListStatus is {{paginate_name.pascalCase()}}ListCompleted) {
            final {{paginate_name.pascalCase()}}ListCompleted completed =
                state.{{paginate_name.snackCase()}}ListStatus as {{paginate_name.pascalCase()}}ListCompleted;
            list = completed.list;
            widget = _createLoadedWidget(list, false);
          } else if (state.{{paginate_name.snackCase()}}ListStatus is {{paginate_name.pascalCase()}}ListLoadingMore) {
            widget = _createLoadedWidget(list, false);
            isLoadingMore = true;
          } else if (state.{{paginate_name.snackCase()}}ListStatus is {{paginate_name.pascalCase()}}ListLoadedMoreError) {
            widget = _createLoadedWidget(list, false);
          } else if (state.{{paginate_name.snackCase()}}ListStatus is {{paginate_name.pascalCase()}}ListError) {
            {{paginate_name.pascalCase()}}ListError followingListError =
                state.{{paginate_name.snackCase()}}ListStatus as {{paginate_name.pascalCase()}}ListError;
            widget = _createErrorWidget(followingListError);
          }
          // widget = _createLoadingWidget();

          return Column(
            children: [
              Expanded(child: widget),
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

  _createLoadingWidget() => ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
                top: 10, bottom: index == list.length - 1 ? 50 : 10),
            child: const Loading{{paginate_name.pascalCase()}}Card(),
          );
        },
      );

  Widget _createLoadedWidget(List<{{paginate_name.pascalCase()}}Model> list, bool isLoading) {
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
        color: CustomColor.red,
        child: ListView.separated(
          itemCount: list.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  EdgeInsets.only(bottom: index == list.length - 1 ? 50 : 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: {{paginate_name.pascalCase()}}Card(
                    {{paginate_name.snackCase()}}Model: list[index],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 20);
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
