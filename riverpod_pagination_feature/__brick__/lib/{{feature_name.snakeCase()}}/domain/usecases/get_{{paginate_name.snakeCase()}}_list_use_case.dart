import 'package:dartz/dartz.dart';
import '../models/{{paginate_name.snakeCase()}}_model.dart';
import '../models/{{paginate_name.snakeCase()}}_list_params.dart';
import '../repositories/{{feature_name.pascalCase()}}_repository.dart';

class Get{{paginate_name.pascalCase()}}ListUseCase
    extends UseCase<Either<Failure, List<{{paginate_name.pascalCase()}}Model>>, {{paginate_name.pascalCase()}}ListParams> {
  final {{feature_name.pascalCase()}}Repository _repository;

  Get{{paginate_name.pascalCase()}}ListUseCase(this._repository);
  @override
  Future<Either<Failure, List<{{paginate_name.pascalCase()}}Model>>> call({{paginate_name.pascalCase()}}ListParams input) {
    return _repository.get{{paginate_name.pascalCase()}}List(input);
  }
}
