import 'package:dartz/dartz.dart';
import '../../../../core/error_handling/failure.dart';
import '../models/{{paginate_name.pascalCase()}}_model.dart';
import '../models/{{paginate_name.pascalCase()}}_params.dart';

abstract class {{feature_name.pascalCase()}}Repository {
  Future<Either<Failure, List<{{paginate_name.pascalCase()}}Model>>> get{{paginate_name.pascalCase()}}List(
      {{paginate_name.pascalCase()}}ListParams params);
}
