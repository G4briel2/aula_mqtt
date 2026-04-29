import 'package:aula_mqtt/model/cliente.dart';
import 'package:sqflite/sqflite.dart';

class ControlCliente {
  static final _databaseName = "teste.db";
  static Database? database;

  ControlCliente();

  Future startDatabase() async{
    if (database != null){
      return database;
    }
    database = await _openOrCreateDatabase();
    return database;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'create table if not exists cliente (nome text, endereco text, cidade text, nasc text)',
    );
  }

  Future insertDatabase (Cliente cli) async{
    Database db = await startDatabase();

    String sql = "";
    sql = 'insert into cliente (nome, cidade, endereco, nasc) values (';
    sql = sql + "'" + cli.nome + "', " + "'" + cli.cidade + "', " + "'" + cli.endereco + "', " + "'" + cli.nascimento + "') ";

    try{
      await db.rawInsert(sql);
      print ("Cliente inserido!");
    } finally {
      //await db.close();
    }
  }

   Future <List<Map<String, dynamic>>> queryFind(String parametro) async {
    Database db = await startDatabase();
    return await (db.rawQuery('select * from cliente where nome like' + "'%" + parametro + "%'"));
   }

  Future _openOrCreateDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = databasePath + _databaseName;
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }


}