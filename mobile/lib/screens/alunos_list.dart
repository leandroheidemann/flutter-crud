import 'package:flutter/material.dart';
import 'package:flutter_crud/services/student_service.dart';
import 'alunos_form.dart';
import '../models/aluno.dart';

class AlunosList extends StatefulWidget {
  final AlunosService alunosService;

  AlunosList({required this.alunosService});

  @override
  _AlunosListState createState() => _AlunosListState();
}

class _AlunosListState extends State<AlunosList> {
  List<Aluno> alunos = [];

  @override
  void initState() {
    super.initState();
    _loadAlunos();
  }

  void _loadAlunos() async {
    try {
      var fetchedAlunos = await widget.alunosService.fetchAlunos();
      print(fetchedAlunos);
      setState(() {
        alunos = fetchedAlunos;
      });
    } catch (e) {
      print(e);
    }
  }

  void onFormSubmit(String nome, String email, String? id) {
    if (id == null) {
      _addNovoAluno(nome, email);
    } else {
      _updateAluno(id, nome, email);
    }
  }

  void _addNovoAluno(String nome, String email) async {
    try {
      await widget.alunosService.addAluno(nome, email);
      _loadAlunos();
    } catch (e) {
      // Handle exceptions
    }
  }

  void _updateAluno(String id, String nome, String email) async {
    try {
      await widget.alunosService.updateAluno(id, nome, email);
      _loadAlunos();
    } catch (e) {
      // Handle exceptions
    }
  }

  void _editAluno(Aluno aluno) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: AlunosForm(onSubmit: onFormSubmit, alunoEditar: aluno),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _removeAluno(String id) async {
    try {
      await widget.alunosService.deleteAluno(id);
      _loadAlunos(); // Reload the list after deletion
    } catch (e) {
      // Handle exceptions
    }
  }

  void _startAddNovoAluno(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: AlunosForm(onSubmit: onFormSubmit),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Alunos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _loadAlunos(),
          ),
        ],
      ),
      body: alunos.isEmpty
          ? Center(
              child: Text('Nenhum aluno encontrado',
                  style: TextStyle(fontSize: 20)),
            )
          : ListView.builder(
              itemCount: alunos.length,
              itemBuilder: (context, index) {
                final aluno = alunos[index];
                return Dismissible(
                  key: ValueKey(aluno.id),
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white, size: 40),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => _removeAluno(aluno.id),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(aluno.name[0]),
                      ),
                      title: Text(aluno.name),
                      subtitle: Text(aluno.email),
                      onTap: () => _editAluno(aluno),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNovoAluno(context),
      ),
    );
  }
}
