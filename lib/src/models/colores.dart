import 'package:flutter/material.dart';

class Colores {
  double multiplicador;
  int valor;
  String nombre;
  Color color;
  String tolerancia;

  Colores({
    @required this.nombre,
    @required this.color,
    this.valor,
    this.multiplicador,
    this.tolerancia,
  });

  static List<Colores> getColoresVal() {
    return <Colores>[
      Colores.negro(),
      Colores.cafe(),
      Colores.rojo(),
      Colores.naranja(),
      Colores.amarillo(),
      Colores.verde(),
      Colores.azul(),
      Colores.violeta(),
      Colores.gris(),
      Colores.blanco(),
    ];
  }

  static List<Colores> getColoresMulti() {
    return getColoresVal()..add(Colores.dorado())..add(Colores.plata());
  }

  static List<Colores> getColoresTol() {
    return <Colores>[
      Colores.cafe(),
      Colores.rojo(),
      Colores.verde(),
      Colores.azul(),
      Colores.violeta(),
      Colores.gris(),
      Colores.dorado(),
      Colores.plata(),
    ];
  }

  Colores.negro() {
    this.nombre = 'Negro';
    this.color = Colors.black;
    this.valor = 0;
    this.multiplicador = 1.0;
  }
  Colores.cafe() {
    this.nombre = 'Marrón';
    this.color = Colors.brown;
    this.valor = 1;
    this.multiplicador = 10.0;
    this.tolerancia = '±1%';
  }
  Colores.rojo() {
    this.nombre = 'Rojo';
    this.color = Colors.red;
    this.valor = 2;
    this.multiplicador = 100.0;
    this.tolerancia = '±2%';
  }
  /////
  Colores.naranja() {
    this.nombre = 'Naranja';
    this.color = Colors.orange;
    this.valor = 3;
    this.multiplicador = 1000.0;
  }
  Colores.amarillo() {
    this.nombre = 'Amarillo';
    this.color = Colors.yellow;
    this.valor = 4;
    this.multiplicador = 10000.0;
  }
  Colores.verde() {
    this.nombre = 'Verde';
    this.color = Colors.green;
    this.valor = 5;
    this.multiplicador = 100000.0;
    this.tolerancia = '±0.5%';
  }
  Colores.azul() {
    this.nombre = 'Azul';
    this.color = Colors.blue;
    this.valor = 6;
    this.multiplicador = 1000000.0;
    this.tolerancia = '±0.25%';
  }
  Colores.violeta() {
    this.nombre = 'Violeta';
    this.color = Colors.purple;
    this.valor = 7;
    this.multiplicador = 10000000.0;
    this.tolerancia = '±0.1%';
  }
  Colores.gris() {
    this.nombre = 'Gris';
    this.color = Colors.grey;
    this.valor = 8;
    this.multiplicador = 100000000.0;
    this.tolerancia = '±0.05%';
  }
  Colores.blanco() {
    this.nombre = 'Blanco';
    this.color = Colors.white;
    this.valor = 9;
    this.multiplicador = 1000000000.0;
  }
  /////
  Colores.dorado() {
    this.nombre = 'Dorado';
    this.color = Color(0xffC08327);
    this.multiplicador = 0.1;
    this.tolerancia = '±5%';
  }
  Colores.plata() {
    this.nombre = 'Plata';
    this.color = Color(0xFFBFBEBF);
    this.multiplicador = 0.01;
    this.tolerancia = '±10%';
  }
}
