import 'package:flutter/material.dart';
import 'package:gastosapp/models/gasto_model.dart';

class ItemGastoWidget extends StatelessWidget {
  final GastoModel gastoData;
  final Function onDelete;

  const ItemGastoWidget({
    super.key,
    required this.gastoData,
    required this.onDelete,
  });

  Widget _getIconForType(String type) {
    print("Tipo de gasto: $type");
    switch (type) {
      case "Alimentos":
        return Image.asset(
          "assets/images/alimentos.webp",
          height: 40,
          width: 40,
        );
      case "Bancos y seguro":
        return Image.asset(
          "assets/images/bancos.webp",
          height: 40,
          width: 40,
        );
      case "Entretenimiento":
        return Image.asset(
          "assets/images/entretenimiento.webp",
          height: 40,
          width: 40,
        );
      case "Otros":
        return Image.asset(
          "assets/images/otros.webp",
          height: 40,
          width: 40,
        );
      case "Servicios":
        return Image.asset(
          "assets/images/servicios.webp",
          height: 40,
          width: 40,
        );
      default:
        return const Icon(
          Icons.money,
          size: 40,
          color: Colors.grey,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: _getIconForType(gastoData.type),
        title: Text(
          gastoData.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          gastoData.datetime,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "S/ ${gastoData.price}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => onDelete(),
            ),
          ],
        ),
      ),
    );
  }
}
