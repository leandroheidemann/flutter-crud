import 'dart:convert';

import 'package:flutter_crud/models/aluno.dart';
import 'package:http/http.dart' as http;

class AlunosService {
  final String apiUrl = 'http://192.168.18.61:8080/student';

  Future<List<Aluno>> fetchAlunos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Aluno.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar alunos');
    }
  }

  Future<http.Response> addAluno(String name, String email) {
    return http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email}),
    );
  }

  Future<http.Response> updateAluno(String id, String name, String email) {
    return http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id, 'name': name, 'email': email}),
    );
  }

  Future<http.Response> deleteAluno(String id) {
    return http.delete(Uri.parse('$apiUrl/$id'));
  }
}
