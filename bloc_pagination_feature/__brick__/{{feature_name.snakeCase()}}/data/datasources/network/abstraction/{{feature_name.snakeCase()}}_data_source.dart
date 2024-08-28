import '../dto/{{paginate_name.snakeCase()}}_dto.dart';
import '../../../../domain/models/{{paginate_name.snakeCase()}}_list_params.dart';

abstract class {{feature_name.pascalCase()}}DataSource {
  Future<List<{{paginate_name.pascalCase()}}Dto>> get{{paginate_name.pascalCase()}}List({{paginate_name.pascalCase()}}ListParams params);
}
