import 'package:flutter/material.dart';
import '../models/aluno.dart';

class AlunosForm extends StatefulWidget {
  final Function onSubmit;
  final Aluno? alunoEditar;

  AlunosForm({required this.onSubmit, this.alunoEditar});

  @override
  _AlunosFormState createState() => _AlunosFormState();
}

class _AlunosFormState extends State<AlunosForm> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.alunoEditar != null) {
      _nomeController.text = widget.alunoEditar!.name;
      _emailController.text = widget.alunoEditar!.email;
    }
  }

  void _submitData() {
    final enteredNome = _nomeController.text;
    final enteredEmail = _emailController.text;

    if (enteredNome.isEmpty || enteredEmail.isEmpty) {
      return;
    }

    print(widget.alunoEditar?.id);

    widget.onSubmit(enteredNome, enteredEmail, widget.alunoEditar?.id);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Nome'),
              controller: _nomeController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            TextButton(
              child: Text('Salvar Aluno'),
              style: TextButton.styleFrom(primary: Colors.purple),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
