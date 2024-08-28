import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../domain/usecases/get_{{paginate_name.snakeCase()}}_list_use_case.dart';
import '../../domain/models/{{paginate_name.snakeCase()}}_model.dart';
import '../../domain/models/{{paginate_name.snakeCase()}}_list_params.dart';
import 'status/{{paginate_name.snakeCase()}}_list_status.dart';

part '{{feature_name.snakeCase()}}_state.dart';
part '{{feature_name.snakeCase()}}_event.dart';

class {{feature_name.pascalCase()}}Bloc extends Bloc<{{feature_name.pascalCase()}}Event, {{feature_name.pascalCase()}}State> {
  int pageNumber = 0;
  int totalPage = 1;
  int pageSize = 30;
  CancelToken cancelToken = CancelToken();

  final List<{{paginate_name.pascalCase()}}Model> _{{paginate_name.snakeCase()}}List = [];
  final Get{{paginate_name.pascalCase()}}ListUseCase _get{{paginate_name.pascalCase()}}ListUseCase;
  {{feature_name.pascalCase()}}Bloc(
    this._get{{paginate_name.pascalCase()}}ListUseCase,
  ) : super({{feature_name.pascalCase()}}State({{paginate_name.snakeCase()}}ListStatus: {{paginate_name.pascalCase()}}ListInitial())) {
    on<PageToInitial{{paginate_name.pascalCase()}}ListEvent>((event, emit) {
      pageNumber = 0;
      _{{paginate_name.snakeCase()}}List.clear();
    });
    on<Get{{paginate_name.pascalCase()}}ListEvent>((event, emit) async {
      if (pageNumber > 0) {
        emit(state.copyWith(new{{paginate_name.pascalCase()}}ListStatus: {{paginate_name.pascalCase()}}ListLoadingMore()));
      } else {
        emit(state.copyWith(new{{paginate_name.pascalCase()}}ListStatus: {{paginate_name.pascalCase()}}ListLoading()));
      }
      cancelToken.cancel(DioException.requestCancelled(
          requestOptions: RequestOptions(), reason: 'new request'));
      await cancelToken.whenCancel;
      if (cancelToken.isCancelled) {
        cancelToken = CancelToken();

        final result = await _get{{paginate_name.pascalCase()}}ListUseCase({{paginate_name.pascalCase()}}ListParams());

        result.fold((failure) {
          _handleFailureResponse(emit, failure);
        }, (success) {
          _handleSuccessResponse(success, emit);
        });
      }
    });
  }
  void _handleFailureResponse(Emitter<{{feature_name.pascalCase()}}State> emit, Failure failure) {
    emit(
        state.copyWith(new{{paginate_name.pascalCase()}}ListStatus: {{paginate_name.pascalCase()}}ListError(failure: failure)));
  }

  void _handleSuccessResponse(
      List<{{paginate_name.pascalCase()}}Model> success, Emitter<{{feature_name.pascalCase()}}State> emit) {
    if (success.isNotEmpty) {
      pageNumber++;
    }
    _{{paginate_name.snakeCase()}}List.addAll(success);
    if (_{{paginate_name.snakeCase()}}List.isEmpty) {
      emit(state.copyWith(new{{paginate_name.pascalCase()}}ListStatus: {{paginate_name.pascalCase()}}ListEmpty()));
    } else {
      emit(state.copyWith(
        new{{paginate_name.pascalCase()}}ListStatus: {{paginate_name.pascalCase()}}ListCompleted(list: _{{paginate_name.snakeCase()}}List),
      ));
    }
  }
}
