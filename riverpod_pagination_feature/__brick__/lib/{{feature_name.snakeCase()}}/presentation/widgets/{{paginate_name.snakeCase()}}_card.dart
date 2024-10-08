import 'package:flutter/material.dart';
import '../../domain/models/{{paginate_name.snakeCase()}}_model.dart';

class {{paginate_name.pascalCase()}}Card extends StatefulWidget {
  const {{paginate_name.pascalCase()}}Card({
    super.key,
    required this.{{paginate_name.snakeCase()}}Model,
  });
  final {{paginate_name.pascalCase()}}Model {{paginate_name.snakeCase()}}Model;
  @override
  State<{{paginate_name.pascalCase()}}Card> createState() => _{{paginate_name.pascalCase()}}CardState();
}

class _{{paginate_name.pascalCase()}}CardState extends State<{{paginate_name.pascalCase()}}Card> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
