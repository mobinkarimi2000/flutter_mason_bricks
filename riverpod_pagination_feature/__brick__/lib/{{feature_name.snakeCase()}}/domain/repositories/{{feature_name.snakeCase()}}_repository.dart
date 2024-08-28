import 'package:dartz/dartz.dart';
import '../models/{{paginate_name.snakeCase()}}_model.dart';
import '../models/{{paginate_name.snakeCase()}}_list_params.dart';

abstract class {{feature_name.pascalCase()}}Repository {
  Future<Either<Failure, List<{{paginate_name.pascalCase()}}Model>>> get{{paginate_name.pascalCase()}}List(
      {{paginate_name.pascalCase()}}ListParams params);
}
