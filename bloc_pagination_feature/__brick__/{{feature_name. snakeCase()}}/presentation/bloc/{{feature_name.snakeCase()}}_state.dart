part of '{{feature_name.pascalCase()}}_bloc.dart';

class {{feature_name.pascalCase()}}State {
  final {{paginate_name.pascalCase()}}ListStatus {{paginate_name.pascalCase()}}ListStatus;

  {{feature_name.pascalCase()}}State({required this.{{paginate_name.pascalCase()}}ListStatus});

  {{feature_name.pascalCase()}}State copyWith({{{paginate_name.pascalCase()}}ListStatus? new{{paginate_name.pascalCase()}}ListStatus}) {
    return {{paginate_name.pascalCase()}}State(
        sampleListStatus: new{{paginate_name.pascalCase()}}ListStatus ?? {{paginate_name.pascalCase()}}ListStatus);
  }
}
