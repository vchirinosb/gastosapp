import 'package:flutter/material.dart';
import 'package:gastosapp/db/db_admin.dart';
import 'package:gastosapp/generated/l10n.dart';
import 'package:gastosapp/models/gasto_model.dart';
import 'package:gastosapp/widgets/item_gasto_widget.dart';
import 'package:gastosapp/widgets/register_modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<GastoModel> gastos = [];

  // Función para eliminar un gasto
  void _deleteGasto(int index) async {
    GastoModel gasto = gastos[index];
    if (gasto.id != null) {
      await DbAdmin().delGasto(gasto.id!);
      setState(() {
        gastos.removeAt(index);
      });
    }
  }

  Widget buildBusquedaWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Buscar por título",
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.4),
            fontSize: 14,
          ),
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          contentPadding: const EdgeInsets.all(16),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  showRegisterModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const RegisterModal(),
        );
      },
    ).then((value) {
      getDataFromDB();
      setState(() {});
    });
  }

  Future<void> getDataFromDB() async {
    gastos = await DbAdmin().obtenerGastos();
    setState(() {});
  }

  @override
  void initState() {
    getDataFromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    print("SE PRESIONA");
                    showRegisterModal();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    height: 100,
                    width: double.infinity,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          "Agregar",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Resumen de gastos",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Gestiona tus gastos de mejor forma",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black45,
                          ),
                        ),
                        buildBusquedaWidget(),
                        Text(S.of(context).helloAlguien("Jhonny")),
                        Expanded(
                          child: ListView.builder(
                            itemCount: gastos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemGastoWidget(
                                gastoData: gastos[index],
                                onDelete: () => _deleteGasto(index),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
