class GastoModel {
  int? id;
  String title;
  double price;
  String datetime;
  String type;

  GastoModel({
    this.id,
    required this.title,
    required this.price,
    required this.datetime,
    required this.type,
  });

  // Crear una instancia de GastoModel a partir de la base de datos
  factory GastoModel.fromDB(Map<String, dynamic> data) => GastoModel(
        id: data["id"],
        title: data["title"],
        price: data["price"],
        datetime: data["datetime"],
        type: data["type"],
      );

  // Convertir GastoModel a un mapa para insertar en la base de datos
  Map<String, dynamic> convertiraMap() => {
        "id": id,
        "title": title,
        "price": price,
        "datetime": datetime,
        "type": type,
      };
}
