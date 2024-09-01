import 'package:flutter/material.dart';
import 'package:gastosapp/models/gasto_model.dart';

class ItemGastoWidget extends StatelessWidget {
  // Map<String, dynamic> gastoData;
  GastoModel gastoData;

  ItemGastoWidget({super.key, 
    required this.gastoData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Image.asset(
          "assets/images/alimentos.webp",
          height: 40,
          width: 40,
        ),
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
        trailing: Text(
          "S/ ${gastoData.price}",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}