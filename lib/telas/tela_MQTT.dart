import 'package:aula_mqtt/widgets/widget_button.dart';
import 'package:aula_mqtt/widgets/widget_input.dart';
import 'package:flutter/material.dart';
class TelaMQTT extends StatefulWidget {
  const TelaMQTT({Key? key}) : super(key: key);

  @override
  State<TelaMQTT> createState() => _TelaMQTTState();
}

class _TelaMQTTState extends State<TelaMQTT> {
  final _txtmensagem = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exemplo MQTT"),
      ),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      children: [
        InputTextos("Digite sua mensagem", "Informe o nome", controller: _txtmensagem),
        Buttons("Enviar mensagem", onPressed: _registrar,),
        Buttons("Buscar mensagem", onPressed: _buscar,),
      ],
    );
  }

  void _registrar() {
  }

  void _buscar() {
  }
}