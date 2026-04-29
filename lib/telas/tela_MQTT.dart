import 'dart:io';

import 'package:aula_mqtt/widgets/widget_button.dart';
import 'package:aula_mqtt/widgets/widget_input.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
class TelaMQTT extends StatefulWidget {
  String id;
  TelaMQTT(this.id);

  @override
  State<TelaMQTT> createState() => _TelaMQTTState();
}

class _TelaMQTTState extends State<TelaMQTT> {
  final _txtmensagem = TextEditingController();
  final cliente = MqttServerClient("test.mosquitto.org", "");

  String pubTopic = "meuTopico/topico/dn";
  String texto = "";

  @override
  void initState() {
    super.initState();
    _startBroker();
  }

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
      padding: const EdgeInsets.all(16),
      children: [
        InputTextos("Digite sua mensagem", "Informe o nome", controller: _txtmensagem),
        Buttons("Enviar mensagem", onPressed: _registrar,),
        Text("Mensagens recebidas:\n$texto")
      ],
    );
  }

  void _registrar() {
    final builder = MqttClientPayloadBuilder();

    builder.addString(_txtmensagem.text);

    print("Publicando mensagem...");
    cliente.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!, retain: true);
  }

  void _buscar() {
  }

  Future <void> _startBroker() async {
    cliente.logging(on: false);
    cliente.setProtocolV311();
    cliente.keepAlivePeriod = 20;
    cliente.onConnected = onConnected;
    cliente.pongCallback = pong;

    final connMess = MqttConnectMessage()
    .withClientIdentifier(widget.id)
    .withWillTopic(pubTopic)
    .withWillMessage("teste de mensagem")
    .startClean()
    .withWillQos(MqttQos.atLeastOnce);

    cliente.connectionMessage = connMess;

    try{
      await cliente.connect();
    } on NoConnectionException catch (e){
      print("Erro de conexão: $e");
      cliente.disconnect();
    } on SocketException catch (e) {
      print("Erro no socket: $e");
      cliente.disconnect();
    }

    if (cliente.connectionStatus!.state == MqttConnectionState.connected){
      print("Conectando no broker");
      cliente.subscribe(pubTopic, MqttQos.exactlyOnce);
      _ouvirMensagens();
    } else {
      print("Falha ao conectar no broker");
      cliente.disconnect();
    }

  }

  void onConnected() => print("Callback: conectado ao broker.");

  void pong() => print("Ping recebido do broker.");

  void _ouvirMensagens() {
    cliente.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;

      final String mensagem = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print ("Mensagem recebido em ${c[0].topic}: $mensagem");

      setState(() {
        texto += "${c[0].topic}: $mensagem\n";
      });
    });
  }
}