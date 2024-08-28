part of '{{feature_name.snakeCase()}}_bloc.dart';

abstract class {{feature_name.pascalCase()}}Event {}

class Get{{paginate_name.pascalCase()}}ListEvent extends {{feature_name.pascalCase()}}Event {}

class PageToInitial{{paginate_name.pascalCase()}}ListEvent extends {{feature_name.pascalCase()}}Event {}
