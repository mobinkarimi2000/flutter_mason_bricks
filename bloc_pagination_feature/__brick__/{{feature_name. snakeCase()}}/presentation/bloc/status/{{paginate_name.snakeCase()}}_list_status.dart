import '../../../../../core/error_handling/failure.dart';
import '../../../domain/models/sample_model.dart';

abstract class {{paginate_name.pascalCase()}}ListStatus {}

class {{paginate_name.pascalCase()}}ListInitial extends {{paginate_name.pascalCase()}}ListStatus {}

class {{paginate_name.pascalCase()}}ListLoading extends {{paginate_name.pascalCase()}}ListStatus {}

class {{paginate_name.pascalCase()}}ListLoadingMore extends {{paginate_name.pascalCase()}}ListStatus {}

class {{paginate_name.pascalCase()}}ListEmpty extends {{paginate_name.pascalCase()}}ListStatus {}

class {{paginate_name.pascalCase()}}ListCompleted extends {{paginate_name.pascalCase()}}ListStatus {
  final List<{{paginate_name.pascalCase()}}Model> list;

  {{paginate_name.pascalCase()}}ListCompleted({required this.list});
}

class {{paginate_name.pascalCase()}}ListError extends {{paginate_name.pascalCase()}}ListStatus {
  final Failure failure;
  {{paginate_name.pascalCase()}}ListError({
    required this.failure,
  });
}

class {{paginate_name.pascalCase()}}ListLoadedMoreError extends {{paginate_name.pascalCase()}}ListStatus {}
