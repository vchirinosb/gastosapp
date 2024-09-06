import 'package:flutter/material.dart';
import 'package:gastosapp/db/db_admin.dart';
import 'package:gastosapp/models/gasto_model.dart';
import 'package:gastosapp/utils/data_general.dart';
import 'package:gastosapp/widgets/field_modal_widget.dart';
import 'package:gastosapp/widgets/item_type_widget.dart';

class RegisterModal extends StatefulWidget {
  const RegisterModal({super.key});

  @override
  State<RegisterModal> createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();

  String typeSelected = 'Alimentos';

  showDateTimePicker() async {
    DateTime? datepicker = await showDatePicker(
        context: context,
        firstDate: DateTime(2022),
        lastDate: DateTime(2030),
        initialDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.light().copyWith(
                dialogTheme: DialogTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                colorScheme: const ColorScheme.light(
                  primary: Colors.black,
                ),
              ),
              child: child!);
        }).then((value) {

      _fechaController.text =
          value == null ? "" : value.toString().substring(0, 10);

      return null;
    });
  
  }

  _buildButtonAdd() {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          GastoModel gasto = GastoModel(
              title: _tituloController.text,
              price: double.parse(_montoController.text),
              datetime: _fechaController.text,
              type: typeSelected);
          DbAdmin().insertarGasto(gasto).then((value) {
            if (value > 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.cyan,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  content: const Text("Se ha registrado corretamente"),
                ),
              );
            } else {
              print("HUBO UN ERROR");
            }
            Navigator.pop(context);
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          "Añadir",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Registra el gasto"),
            const SizedBox(
              height: 16,
            ),
            FieldModalWidget(
              hint: "Ingresa el título",
              controller: _tituloController,
            ),
            FieldModalWidget(
              hint: "Ingresa el monto",
              controller: _montoController,
              isNumberKeyBoard: true,
            ),
            FieldModalWidget(
              hint: "Ingresa la fecha",
              controller: _fechaController,
              isDatePicker: true,
              function: () {
                showDateTimePicker();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: types
                  .map(
                    (e) => ItemTypeWidget(
                      data: e,
                      isSelected: e["name"] == typeSelected,
                      tap: () {
                        typeSelected = e["name"];
                        setState(() {},);
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            _buildButtonAdd(),
          ],
        ),
      ),
    );
  }
}
