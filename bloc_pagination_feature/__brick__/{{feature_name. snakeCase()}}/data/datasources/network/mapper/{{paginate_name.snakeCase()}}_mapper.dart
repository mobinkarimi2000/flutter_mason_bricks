import '../../../../../../core/mapper/mapper.dart';
import '../dto/{{paginate_name.snackCase()}}_dto.dart';
import '../../../../domain/models/{{paginate_name.snackCase()}}_model.dart';

class {{paginate_name.pascalCase()}}Mapper extends EntityMapper<{{paginate_name.pascalCase()}}Dto, {{paginate_name.pascalCase()}}Model> {
  @override
  {{paginate_name.pascalCase()}}Model mapFromEntity({{paginate_name.pascalCase()}}Dto entity) {
    // TODO: implement mapFromEntity
    throw UnimplementedError();
  }

  @override
  {{paginate_name.pascalCase()}}Dto mapToEntity({{paginate_name.pascalCase()}}Model domainModel) {
    // TODO: implement mapToEntity
    throw UnimplementedError();
  }
}
