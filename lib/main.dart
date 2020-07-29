import './src/models/colores.dart';
import 'package:flutter/material.dart';

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
  static List<Colores> barraMultiplicador = Colores.getColoresMulti();
  static List<Colores> barraTolerancias = Colores.getColoresTol();

  int valor1 = 0;
  int valor2 = 0;
  int mIndex = 0;
  int tolIndex = 0;
  double valFin = 0.0;
  String prefijo = '';
  String texto = '0 Ω';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 300,
                color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      RaisedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      agregarResistencia(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget bottomSheetSimple(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {},
      ),
    );
  }

  displayBottomSheet() {
    double heightOfModalBottomSheet = 100;
    int value1 = 0;
    showModalBottomSheet(
      backgroundColor: Colors.blueGrey,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context,
              StateSetter setStateUp /*You can rename this!*/) {
            return agregarResistencia();
          },
        );
      },
    );
  }

  Widget agregarResistencia() {
    return Column(
      children: <Widget>[
        _textos(),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: _barraUno()),
              Expanded(child: _barraDos()),
              Expanded(child: _barraMultiplicador()),
              Expanded(child: _barraTolerancias()),
            ],
          ),
        ),
        Container(
            child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(child: Text('$texto')),
              ),
            ),
            Expanded(
              child: FlatButton(
                onPressed: () {
                  setState(() {});
                },
                child: Row(
                  children: <Widget>[
                    Text('Guardar'),
                    SizedBox(width: 30.0),
                    Icon(Icons.save),
                  ],
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }

  String calcularResistencia() {
    String tol = barraTolerancias[tolIndex].tolerancia;
    String valorRes = '';
    int val;
    valorRes = valor1.toString() + valor2.toString();
    // val = int.parse(valorRes);
    double valordouble = double.parse(valorRes);
    double valor = valordouble * barraMultiplicador[mIndex].multiplicador;
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
    return '${valFin.toStringAsFixed(2)} $prefijo';
  }

  Widget _textos() {
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

  Widget _barraUno( ) {
    int _index = 0;
    return SizedBox(
      height: 80, // card height
      width: 80,
      child: PageView.builder(
        itemCount: barra1.length,
        scrollDirection: Axis.vertical,
        controller: PageController(viewportFraction: 0.7, keepPage: true),
        onPageChanged: (int index) => setState(() {
          _index = index;
          valor1 = index;
          texto  = calcularResistencia();
        }),
        itemBuilder: (context, i) {
          return Container(
            child: Card(
              color: barra1[i].color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1)),
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

  Widget _barraDos( ) {
    int _index = 0;
    return SizedBox(
      height: 80, // card height
      width: 80,
      child: PageView.builder(
        itemCount: barra2.length,
        scrollDirection: Axis.vertical,
        controller: PageController(viewportFraction: 0.7),
        onPageChanged: (int index) => setState(() {
          _index = index;
          valor2 = index;
          texto  = calcularResistencia();
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

  Widget _barraMultiplicador( ) {
    int _index = 0;
    return SizedBox(
      height: 80, // card height
      width: 80,
      child: PageView.builder(
        itemCount: barraMultiplicador.length,
        scrollDirection: Axis.vertical,
        controller: PageController(viewportFraction: 0.7),
        onPageChanged: (int index) => setState(() {
          _index = index;
          mIndex = index;
          texto  = calcularResistencia();
        }),
        itemBuilder: (context, i) {
          return Container(
            child: Card(
              color: barraMultiplicador[i].color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  barraMultiplicador[i].nombre,
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

  Widget _barraTolerancias( ) {
    int _index = 0;
    return SizedBox(
      height: 80, // card height
      width: 80,
      child: PageView.builder(
        itemCount: barraTolerancias.length,
        scrollDirection: Axis.vertical,
        controller: PageController(viewportFraction: 0.7),
        onPageChanged: (int index) => setState(() {
          _index   = index;
          tolIndex = index;
          texto    = calcularResistencia();
        }),
        itemBuilder: (context, i) {
          return Container(
            child: Card(
              color: barraTolerancias[i].color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  barraTolerancias[i].nombre,
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
