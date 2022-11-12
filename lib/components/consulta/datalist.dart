import 'dart:async';
import 'package:flutter/material.dart';
import 'package:recycle/components/consulta/consulta.dart';
import 'package:recycle/components/searchwidget/searchwidget.dart';

import '../../api/residuosapi.dart';
import '../../model/residuo.dart';

class DataList extends StatefulWidget {
  const DataList({Key? key}) : super(key: key);

  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  String query = '';
  List<Residuo> residuos = [];
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final residuos = await ResiduosApi.getResiduos(query);

    setState(() => this.residuos = residuos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // add margin top 80, left 20, right 20, bottom 20
          margin: const EdgeInsets.only(top: 40, left: 0, right: 0, bottom: 20),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // add back button
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    'Filtro por residuo',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              buildSearch(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 0),
                  itemCount: residuos.length,
                  itemBuilder: (context, index) {
                    final residuo = residuos[index];
                    return buildResiduo(residuo, context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: '¿Cúal es tu residuo?',
        onChanged: searchResiduo,
      );

  Future searchResiduo(String query) async => debounce(() async {
        final residuos = await ResiduosApi.getResiduos(query);
        if (!mounted) return;
        setState(() {
          this.query = query;
          this.residuos = residuos;
        });
      });
}

Widget buildResiduo(Residuo residuo, context) => ListTile(
      title: Text(residuo.nombre),
      subtitle: Text(residuo.descripcion),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Consulta(
              residuo: residuo,
            ),
          ),
        );
      },
    );
