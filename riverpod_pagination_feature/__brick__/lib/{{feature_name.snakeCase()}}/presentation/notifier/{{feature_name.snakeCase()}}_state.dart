
class {{feature_name.pascalCase()}}State {
  final {{paginate_name.pascalCase()}}ListStatus {{paginate_name.snakeCase()}}ListStatus;

  {{feature_name.pascalCase()}}State({required this.{{paginate_name.snakeCase()}}ListStatus});

  {{feature_name.pascalCase()}}State copyWith({{{paginate_name.pascalCase()}}ListStatus? new{{paginate_name.pascalCase()}}ListStatus}) {
    return {{feature_name.pascalCase()}}State(
        {{paginate_name.snakeCase()}}ListStatus: new{{paginate_name.pascalCase()}}ListStatus ?? {{paginate_name.snakeCase()}}ListStatus);
  }
}
