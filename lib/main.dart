import './src/models/colores.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  static Map<String, dynamic> mapa1 = {
    'nombre': 'valoresUno',
    'colores': barra1
  };
  static Map<String, dynamic> mapa2 = {
    'nombre': 'valoresDos',
    'colores': barra2,
  };
  static Map<String, dynamic> mapaMult = {
    'nombre': 'mult',
    'colores': barraMultiplicador,
  };
  static Map<String, dynamic> mapaTol = {
    'nombre': 'valoresDos',
    'colores': barraTolerancias
  };

  int valor1 = 0;
  int valor2 = 0;
  int mIndex = 0;
  int tolIndex = 0;
  double valFin = 0.0;
  String prefijo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListWheelScrollView demo'),
      ),
      body: Column(
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
          Text('${valFin.toStringAsFixed(2)} $prefijo'),
        ],
      ),
    );
  }

  _calcularResistencia() {
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

    setState(() {});
    // valorInt * barraMultiplicador[multiplicador].multiplicador.toInt());
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

  Widget _barra(List<Colores> lista) {
    int _index = 0;
    return SizedBox(
      height: 80, // card height
      width: 80,
      child: PageView.builder(
        itemCount: lista.length,
        scrollDirection: Axis.vertical,
        controller: PageController(viewportFraction: 0.7, keepPage: true),
        onPageChanged: (int index) => setState(() {
          _index = index;
          valor1 = index;
          _calcularResistencia();
        }),
        itemBuilder: (context, i) {
          return Container(
            child: Card(
              color: lista[i].color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  lista[i].nombre,
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

  Widget _barraUno() {
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
          _calcularResistencia();
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

  Widget _barraDos() {
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
          _calcularResistencia();
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

  Widget _barraMultiplicador() {
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
          _calcularResistencia();
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

  Widget _barraTolerancias() {
    int _index = 0;
    return SizedBox(
      height: 80, // card height
      width: 80,
      child: PageView.builder(
        itemCount: barraTolerancias.length,
        scrollDirection: Axis.vertical,
        controller: PageController(viewportFraction: 0.7),
        onPageChanged: (int index) => setState(() {
          _index = index;
          tolIndex = index;
          _calcularResistencia();
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

class MyItem extends StatelessWidget {
  final int index;

  MyItem({@required this.index, Key key}) : super(key: key);

  static const colors = [
    Colors.pink,
    Colors.indigo,
    Colors.grey,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: colors[index % colors.length],
        child: Center(
          child: RaisedButton(
            color: colors[index % colors.length],
            onPressed: () {
              print('boton presionado');
            },
            child: Text(
              '$index',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
