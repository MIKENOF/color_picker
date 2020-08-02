import 'package:flutter/material.dart';

import './src/models/resistencia.dart';
import './src/models/colores.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resistencias',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<Colores> barra1 = Colores.getColoresVal();
  static List<Colores> barra2 = Colores.getColoresVal();
  static List<Colores> barraMultiplicadorList = Colores.getColoresMulti();
  static List<Colores> barraToleranciasList = Colores.getColoresTol();

  ScrollController _scrollController = new ScrollController();

  int valor1 = 0;
  int valor2 = 0;
  int mIndex = 0;
  int tolIndex = 0;
  double valFin = 0.0;
  String prefijo = '';
  String valRes = '0.00 Ω ±1%';

  List<Resistencia> listaResistencias = [
    Resistencia(
        indexBarra1: 2,
        indexBarra2: 2,
        indexBarraMult: 1,
        indexBarraTol: 6,
        valor: '220.00 Ω ±5%'),
    Resistencia(
        indexBarra1: 1,
        indexBarra2: 0,
        indexBarraMult: 2,
        indexBarraTol: 6,
        valor: '1.00 KΩ ±5%'),
    Resistencia(
        indexBarra1: 1,
        indexBarra2: 0,
        indexBarraMult: 3,
        indexBarraTol: 6,
        valor: '10.00 KΩ ±5%'),
  ];
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // _agregar10();

      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colores Resistencias'),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(10.0),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            // reverse: true,
            controller: _scrollController,
            itemCount: listaResistencias.length,
            itemBuilder: (context, index) {
              return Dismissible(
                background: Container(
                  padding: EdgeInsets.only(left: 12.0),
                  color: Colors.blueGrey,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.delete),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Eliminar'),
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                ),
                onDismissed: (direction) {
                  setState(() {
                    listaResistencias.removeAt(index);
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(
                    duration: Duration(milliseconds: 200),
                    content: Text("Resistencia Eliminado"),
                  ));
                },
                key: UniqueKey(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color:
                                  barra1[listaResistencias[index].indexBarra1]
                                      .color,
                            ),
                            height: 50,
                            width: 20,
                          ),
                          Container(height: 50, width: 2),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color:
                                  barra2[listaResistencias[index].indexBarra2]
                                      .color,
                            ),
                            height: 50,
                            width: 20,
                            // color: barra2[listaResistencias[index].indexBarra2].color,
                          ),
                          Container(height: 50, width: 2),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: barraMultiplicadorList[
                                      listaResistencias[index].indexBarraMult]
                                  .color,
                            ),
                            height: 50,
                            width: 20,
                          ),
                          Container(height: 50, width: 2),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: barraToleranciasList[
                                      listaResistencias[index].indexBarraTol]
                                  .color,
                            ),
                            height: 50,
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                                'Valor: ${listaResistencias[index].valor}'),
                          ),
                        ],
                      ),
                      // Divider(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          valor1 = 0;
          valor2 = 0;
          mIndex = 0;
          tolIndex = 0;
          valFin = 0.0;
          prefijo = '';
          valRes = '0.00 Ω ±1%';
          displayBottomSheet(context);
        },
      ),
    );
  }

  displayBottomSheet(BuildContext context) {
    double heightOfModalBottomSheet = 250;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: heightOfModalBottomSheet,
          child: Scaffold(
            body: StatefulBuilder(
              builder: (BuildContext context,
                  StateSetter setStateBuilder /*You can rename this!*/) {
                return Column(
                  children: <Widget>[
                    agregarResistencia(context, setStateBuilder),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget agregarResistencia(BuildContext context, Function setStateBuilder) {
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: Column(
        children: <Widget>[
          textos(),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(child: barraUno(setStateBuilder)),
                Expanded(child: barraDos(setStateBuilder)),
                Expanded(child: barraMultiplicador(setStateBuilder)),
                Expanded(child: barraTolerancias(setStateBuilder))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Text('Valor: $valRes'),
              ),
              Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.only(right: 12.0, left: 12.0),
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      if (valor1 == 0 && valor2 == 0) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            duration: Duration(milliseconds: 600),
                            content: Text('Valores Inválidos')));
                        return;
                      } else {
                        listaResistencias.insert(
                          0,
                          Resistencia(
                            indexBarra1: valor1,
                            indexBarra2: valor2,
                            indexBarraMult: mIndex,
                            indexBarraTol: tolIndex,
                            valor: valRes,
                          ),
                        );
                        Navigator.pop(context);
                        _scrollController.animateTo(
                            // _scrollController.position.maxScrollExtent + 66,
                            0.0,
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeOutCirc);
                      }
                    });
                  },
                  child: Text('Guardar'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  calcularResistencia() {
    String tol = barraToleranciasList[tolIndex].tolerancia;
    String valorRes = '';
    valorRes = valor1.toString() + valor2.toString();
    // val = int.parse(valorRes);
    double valordouble = double.parse(valorRes);
    double valor = valordouble * barraMultiplicadorList[mIndex].multiplicador;
    print(valor.toStringAsFixed(2));
    if (valor ~/ 1000 > 0) {
      valFin = valor / 1000;
      prefijo = 'KΩ $tol';
      if (valor ~/ 1000000 > 0) {
        valFin = valor / 1000000;
        prefijo = 'MΩ $tol';
        if (valor ~/ 1000000000 > 0) {
          valFin = valor / 1000000000;
          prefijo = 'GΩ $tol';
        }
      }
    } else {
      valFin = valor;
      prefijo = 'Ω $tol';
    }
    valRes = '${valFin.toStringAsFixed(2)} $prefijo';
    // valorInt * barraMultiplicador[multiplicador].multiplicador.toInt());
  }

  Widget textos() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Center(
                  child: Text('Banda 1', overflow: TextOverflow.ellipsis))),
          Expanded(
              child: Center(
                  child: Text('Banda 2', overflow: TextOverflow.ellipsis))),
          Expanded(
              child: Center(
                  child:
                      Text('Multiplicador', overflow: TextOverflow.ellipsis))),
          Expanded(
              child: Center(
                  child: Text('Tolerancia', overflow: TextOverflow.ellipsis)))
        ],
      ),
    );
  }

  Widget barraUno(Function setStateBuilder) {
    return SizedBox(
      height: 80, // card height
      width: 80,
      child: PageView.builder(
        itemCount: barra1.length,
        scrollDirection: Axis.vertical,
        controller: PageController(viewportFraction: 0.7, keepPage: true),
        onPageChanged: (int index) => setStateBuilder(() {
          valor1 = index;
          calcularResistencia();
        }),
        itemBuilder: (context, i) {
          return Container(
            child: Card(
              color: barra1[i].color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  barra1[i].nombre,
                  style: TextStyle(
                    fontSize: 16,
                    color: i == 0 ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget barraDos(Function setStateBuilder) {
    return SizedBox(
      height: 80, // card height
      width: 80,
      child: PageView.builder(
        itemCount: barra2.length,
        scrollDirection: Axis.vertical,
        controller: PageController(viewportFraction: 0.7),
        onPageChanged: (int index) => setStateBuilder(() {
          valor2 = index;
          calcularResistencia();
        }),
        itemBuilder: (context, i) {
          return Container(
            child: Card(
              color: barra2[i].color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  barra2[i].nombre,
                  style: TextStyle(
                    fontSize: 16,
                    color: i == 0 ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget barraMultiplicador(Function setStateBuilder) {
    return SizedBox(
      height: 80, // card height
      width: 80,
      child: PageView.builder(
        itemCount: barraMultiplicadorList.length,
        scrollDirection: Axis.vertical,
        controller: PageController(viewportFraction: 0.7),
        onPageChanged: (int index) => setStateBuilder(() {
          mIndex = index;
          calcularResistencia();
        }),
        itemBuilder: (context, i) {
          return Container(
            child: Card(
              color: barraMultiplicadorList[i].color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  barraMultiplicadorList[i].nombre,
                  style: TextStyle(
                    fontSize: 16,
                    color: i == 0 ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget barraTolerancias(Function setStateBuilder) {
    return SizedBox(
      height: 80, // card height
      width: 80,
      child: PageView.builder(
        itemCount: barraToleranciasList.length,
        scrollDirection: Axis.vertical,
        controller: PageController(viewportFraction: 0.7),
        onPageChanged: (int index) => setStateBuilder(() {
          tolIndex = index;
          calcularResistencia();
        }),
        itemBuilder: (context, i) {
          return Container(
            child: Card(
              color: barraToleranciasList[i].color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  barraToleranciasList[i].nombre,
                  style: TextStyle(
                    fontSize: 16,
                    color: i == 0 ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
