import '../abstraction/{{feature_name.snackCase()}}_data_source.dart';
import '../dto/{{feature_name.snackCase()}}_dto.dart';
import '../../../../domain/models/{{feature_name.snackCase()}}
_list_params.dart';

class {{feature_name.pascalCase()}}DataSourceImpl extends {{feature_name.pascalCase()}}DataSource {
  @override
  Future<List<{{feature_name.pascalCase()}}Dto>> get{{feature_name.pascalCase()}}List({{feature_name.pascalCase()}}ListParams params) {
    // TODO: implement get{{feature_name.pascalCase()}}List
    throw UnimplementedError();
  }
}
