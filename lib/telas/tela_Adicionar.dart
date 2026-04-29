import 'package:aula_mqtt/control/ControlCliente.dart';
import 'package:aula_mqtt/model/cliente.dart';
import 'package:aula_mqtt/widgets/widget_button.dart';
import 'package:aula_mqtt/widgets/widget_input.dart';
import 'package:flutter/material.dart';
class TelaAdicionar extends StatefulWidget {
  @override
  _TelaAdicionarState createState() => _TelaAdicionarState();
}

class _TelaAdicionarState extends State<TelaAdicionar> {
  @override
  final _nome = TextEditingController();
  final _cidade = TextEditingController();
  final _endereco = TextEditingController();
  final _nascimento = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar cliente"),
      ),
      body: _body(),
    );
  }

  _body() {
    return ListView(
         children: [
          InputTextos("Digite o nome", "Informe o nome", controller: _nome),
          InputTextos("Digite o endereço", "Informe o endereço", controller: _endereco),
          InputTextos("Digite a cidade", "Informe a cidade", controller: _cidade),
          InputTextos("Digite o nascimento", "Informe o nascimento", controller: _nascimento),
          Buttons("Registrar", onPressed: _registrar,)
        ],
    );
  }


  void _registrar() {
    var control = new ControlCliente();
    var cli = new Cliente(
      nome: _nome.text.toString(),
      endereco: _endereco.text.toString(),
      cidade: _cidade.text.toString(),
      nascimento: _nascimento.text.toString()
    );

    control.insertDatabase(cli);
  }
}
