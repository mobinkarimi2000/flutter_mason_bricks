import 'package:flutter/material.dart';

class {{paginate_name.pascalCase()}}ListScreen extends StatefulWidget {
  const {{paginate_name.pascalCase()}}ListScreen({super.key});

  @override
  State<{{paginate_name.pascalCase()}}ListScreen> createState() => _{{paginate_name.pascalCase()}}ListScreenState();
}

class _{{paginate_name.pascalCase()}}ListScreenState extends State<{{paginate_name.pascalCase()}}ListScreen> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
