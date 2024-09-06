import 'dart:io';
import 'package:gastosapp/models/gasto_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbAdmin {
  Database? myDatabase;

  static final DbAdmin _instance = DbAdmin._();
  DbAdmin._();

  factory DbAdmin() {
    return _instance;
  }

  Future<Database?> _checkDataBase() async {
    myDatabase ??= await _initDatabase();
    return myDatabase;
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String pathDatabase = join(directory.path, "PagosDB.db");

    return await openDatabase(
      pathDatabase,
      version: 1,
      onCreate: (Database db, int version) {
        db.execute("""CREATE TABLE GASTOS(
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    title TEXT,
                    price REAL,
                    datetime TEXT,
                    type TEXT)
                    """);
      },
    );
  }

  // Insertar gasto
  Future<int> insertarGasto(GastoModel gasto) async {
    Database? db = await _checkDataBase();
    int res = await db!.insert(
      "GASTOS",
      gasto.convertiraMap(),
    );

    return res;
  }

  // Obtener gastos
  obtenerGastos() async {
    Database? db = await _checkDataBase();
    List data = await db!.query("GASTOS");
    List<GastoModel> gastosList =
        data.map((e) => GastoModel.fromDB(e)).toList();
    return gastosList;
  }

  // Eliminar gasto por Id
  Future<int> delGasto(int id) async {
    Database? db = await _checkDataBase();
    int res = await db!.delete("GASTOS", where: 'id = ?', whereArgs: [id]);

    return res;
  }

  // Actualizar gasto
  updGasto() async {
    Database? db = await _checkDataBase();
    int res = await db!.update(
      "GASTOS",
      {
        "title": "actualizando",
        "price": 0,
        "type": "Banco",
      },
      where: "id=1",
    );
  }
}
