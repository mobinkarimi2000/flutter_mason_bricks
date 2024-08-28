import 'package:dartz/dartz.dart';
import '../../../../core/error_handling/custom_exception.dart';
import '../../../../core/error_handling/failure.dart';
import '../../../../core/utils/utils.dart';
import '../datasources/network/mapper/{{paginate_name.snackCase()}}_mapper.dart';
import '../../domain/models/{{paginate_name.snackCase()}}_list_params.dart';
import '../../domain/models/{{paginate_name.snackCase()}}_model.dart';

import '../datasources/network/abstraction/{{feature_name.snackCase()}}_data_source.dart';
import '../../domain/repositories/{{feature_name.snackCase()}}_repository.dart';

class {{feature_name.pascalCase()}}RepositoryImpl extends {{feature_name.pascalCase()}}Repository {
  final {{feature_name.pascalCase()}}DataSource _sampleDataSource;
  final {{feature_name.pascalCase()}}Mapper _sampleMapper;
  {{feature_name.pascalCase()}}RepositoryImpl(this._sampleDataSource, this._sampleMapper);
  @override
  Future<Either<Failure, List<{{feature_name.pascalCase()}}Model>>> get{{feature_name.pascalCase()}}List(
      {{feature_name.pascalCase()}}ListParams params) async {
    try {
      final listDto = await _sampleDataSource.get{{feature_name.pascalCase()}}List(params);
      final listModel = listDto
          .map(
            (e) => _sampleMapper.mapFromEntity(e),
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
