import '../dto/{{feature_name.snackCase()}}_dto.dart';
import '../../../../domain/models/{{feature_name.snackCase()}}_list_params.dart';

abstract class {{feature_name.pascalCase()}}DataSource {
  Future<List<{{feature_name.pascalCase()}}Dto>> get{{feature_name.pascalCase()}}List({{feature_name.pascalCase()}}ListParams params);
}
