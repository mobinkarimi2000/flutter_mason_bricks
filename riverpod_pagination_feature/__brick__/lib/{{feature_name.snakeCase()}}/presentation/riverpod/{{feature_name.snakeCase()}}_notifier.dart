import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/{{paginate_name.snakeCase()}}_list_params.dart';
import '../../domain/models/{{paginate_name.snakeCase()}}_model.dart';
import '../../domain/usecases/get_{{paginate_name.snakeCase()}}_list_use_case.dart';
import '{{feature_name.snakeCase()}}_state.dart';
import 'status/{{paginate_name.snakeCase()}}_list_status.dart';

class {{feature_name.pascalCase()}}Notifier extends StateNotifier<{{feature_name.pascalCase()}}State> {
  final Get{{paginate_name.pascalCase()}}ListUseCase _get{{paginate_name.pascalCase()}}ListUseCase;

  int pageNumber = 1;
  int pageSize = 10;
  int totalPage = 1;
  final List<{{paginate_name.pascalCase()}}Model> _{{paginate_name.snakeCase()}}List = [];

  {{feature_name.pascalCase()}}Notifier(this._get{{feature_name.pascalCase()}}ListUseCase)
      : super({{feature_name.pascalCase()}}State({{paginate_name.snakeCase()}}ListStatus: {{paginate_name.pascalCase()}}ListInitial()));

  pageToInitial{{paginate_name.pascalCase()}}List() {
    pageNumber = 1;
    _{{paginate_name.snakeCase()}}List.clear();
  }

  get{{paginate_name.pascalCase()}}List({required BuildContext context}) async {
    if (pageNumber > 1) {
      state = state.copyWith(new{{paginate_name.pascalCase()}}ListStatus: {{paginate_name.pascalCase()}}ListLoadingMore());
    } else {
      state = state.copyWith(new{{paginate_name.pascalCase()}}ListStatus: {{paginate_name.pascalCase()}}ListLoading());
    }
    await Future.delayed(const Duration(seconds: 1));
    final result = await _get{{paginate_name.pascalCase()}}ListUseCase({{paginate_name.pascalCase()}}ListParams(
      pageNumber: pageNumber,
      pageSize: pageSize,
    ));

    result.fold(
      (failure) {
        handleFailure{{paginate_name.pascalCase()}}List(failure);
        Utils.showSnack(message: failure.message ?? '', context: context);
      },
      (success) {
        handleSuccess{{paginate_name.pascalCase()}}List(success);
      },
    );
  }

  void handleSuccess{{paginate_name.pascalCase()}}List(List<{{paginate_name.pascalCase()}}Model> success) {
    if (success.isNotEmpty) {
      _{{paginate_name.snakeCase()}}List.addAll(success);
      pageNumber++;
    }
    if (_{{paginate_name.snakeCase()}}List.isEmpty) {
      state = state.copyWith(new{{paginate_name.pascalCase()}}ListStatus: {{paginate_name.pascalCase()}}ListEmpty());
    } else {
      state = state.copyWith(
          new{{paginate_name.pascalCase()}}ListStatus: {{paginate_name.pascalCase()}}ListCompleted(list: _{{paginate_name.snakeCase()}}List));
    }
  }

  void handleFailure{{paginate_name.pascalCase()}}List(Failure failure) {
    if (_{{paginate_name.snakeCase()}}List.isNotEmpty) {
      state =
          state.copyWith(new{{paginate_name.pascalCase()}}ListStatus: {{paginate_name.pascalCase()}}ListLoadedMoreError());
    } else {
      state = state.copyWith(
          new{{paginate_name.pascalCase()}}ListStatus: {{paginate_name.pascalCase()}}ListError(failure: failure));
    }
  }
}
