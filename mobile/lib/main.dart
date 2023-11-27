import 'package:flutter/material.dart';
import 'package:flutter_crud/screens/alunos_list.dart';
import 'package:flutter_crud/services/student_service.dart';

void main() {
  final alunosService = AlunosService();
  runApp(MyApp(alunosService: alunosService));
}

class MyApp extends StatelessWidget {
  final AlunosService alunosService;

  MyApp({required this.alunosService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Alunos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AlunosList(alunosService: alunosService),
    );
  }
}
