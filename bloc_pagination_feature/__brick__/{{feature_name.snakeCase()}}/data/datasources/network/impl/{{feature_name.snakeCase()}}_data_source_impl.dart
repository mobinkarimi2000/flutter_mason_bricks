import '../abstraction/{{feature_name.snackCase()}}_data_source.dart';
import '../dto/{{paginate_name.snakeCase()}}_dto.dart';
import '../../../../domain/models/{{paginate_name.snakeCase()}}_list_params.dart';

class {{feature_name.pascalCase()}}DataSourceImpl extends {{feature_name.pascalCase()}}DataSource {
  @override
  Future<List<{{paginate_name.pascalCase()}}Dto>> get{{paginate_name.pascalCase()}}List({{paginate_name.pascalCase()}}ListParams params) {
    // TODO: implement get{{paginate_name.pascalCase()}}List
    throw UnimplementedError();
  }
}
