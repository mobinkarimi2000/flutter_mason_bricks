import 'package:dartz/dartz.dart';
import '../datasources/network/mapper/{{paginate_name.snakeCase()}}_mapper.dart';
import '../../domain/models/{{paginate_name.snakeCase()}}_list_params.dart';
import '../../domain/models/{{paginate_name.snakeCase()}}_model.dart';

import '../datasources/network/abstraction/{{feature_name.snakeCase()}}_data_source.dart';
import '../../domain/repositories/{{feature_name.snakeCase()}}_repository.dart';

class {{feature_name.pascalCase()}}RepositoryImpl extends {{feature_name.pascalCase()}}Repository {
  final {{feature_name.pascalCase()}}DataSource _{{feature_name.snakeCase()}}DataSource;
  final {{paginate_name.pascalCase()}}Mapper _{{paginate_name.snakeCase()}}Mapper;
  {{feature_name.pascalCase()}}RepositoryImpl(this._{{feature_name.snakeCase()}}DataSource, this. _{{paginate_name.snakeCase()}}Mapper);
  @override
  Future<Either<Failure, List<{{paginate_name.pascalCase()}}Model>>> get{{paginate_name.pascalCase()}}List(
      {{paginate_name.pascalCase()}}ListParams params) async {
    try {
      final listDto = await _{{feature_name.snakeCase()}}DataSource.get{{paginate_name.pascalCase()}}List(params);
      final listModel = listDto
          .map(
            (e) => _{{paginate_name.snakeCase()}}Mapper.mapFromEntity(e),
          )
          .toList();
      return right(listModel);
    } on NoInternetConnectionException {
      return left(NoInternetConnectionFailure());
    } on BadRequestException catch (e) {
      return left(
          BadRequestFailure(errorCode: e.errorCode, message: e.errorMessage));
    } on RestApiException catch (e) {
      return left(Utils.handleRestApiException(e));
    } catch (e) {
      return left(Utils.handleUnknownException(e));
    }
  }
}
