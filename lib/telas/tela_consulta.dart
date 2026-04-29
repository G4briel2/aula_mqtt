import 'package:aula_mqtt/control/ControlCliente.dart';
import 'package:aula_mqtt/widgets/widget_button.dart';
import 'package:aula_mqtt/widgets/widget_input.dart';
import 'package:aula_mqtt/widgets/widget_text_custom.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class TelaConsulta extends StatefulWidget {
  @override
  _TelaConsultaState createState() => _TelaConsultaState();
}

class _TelaConsultaState extends State<TelaConsulta> {
  String textoPesquisa = "";
  final _inputPesquisa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    start();
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultar cliente"),
      ),
      body: _body(),
    );
  }

  _body() {
    return ListView(

      children: [
        Buttons("Pesquisar", onPressed: _pesquisar),
        InputTextos(
            "", "Digite um nome para pesquisa", controller: _inputPesquisa),
        TextosCustom(textoPesquisa, 19, Colors.red)
      ],
    );
  }

  Future _pesquisar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('suaPesquisa', _inputPesquisa.text.toString());
    var control = new ControlCliente();
    int index = 0;
    textoPesquisa = "\n";

    List<Map<String, dynamic>> list = await control.queryFind(_inputPesquisa.text.toString());
    list.forEach((element){
      textoPesquisa = textoPesquisa + list[index]['nome'].toString() + "\n";
      index++;
    });
    setState(() {

    });
  }

  Future start() async{
    final prefs = await SharedPreferences.getInstance();
    _inputPesquisa.text = prefs.getString('suaPesquisa').toString();
  }
}

