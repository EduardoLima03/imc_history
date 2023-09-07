import 'package:flutter/material.dart';

class ImcModel {
  final String _id = UniqueKey().toString();
  String _data = '';
  double _altura = 0.0;
  double _peso = 0.0;
  double _imc = 0.0;

  ImcModel({required double altura, required double peso}) {
    _altura = altura;
    _peso = peso;
    _data = DateTime.now().toString();
    calculateImc();
  }

  String get id => _id;

  String get data => _data;

  set data(String value) {
    _data = value;
  }

  double get altura => _altura;

  set altura(double value) {
    _altura = value;
  }

  double get peso => _peso;

  set peso(double value) {
    _peso = value;
  }

  double get imc => _imc;

  /// Calcula o IMC.
  ///
  /// Retorna o valor em double.
  double calculateImc() {
    try {
      // tive que multiplicar por 10000 para fica proximo dovalor de classificacao.
      double resultado = peso / (altura * altura) * 10000;
      // Converto o resultado em string com duas posicao apos a ',' e converte a numeros novamente.
      resultado = double.parse(resultado.toStringAsFixed(2));
      _imc = resultado;
      return resultado;
    } catch (e) {
      debugPrint(e.toString());
    }
    return _imc;
  }

  /// Classifica o nivel de peso.
  ///
  /// [value] valor do imc.
  ///
  /// Retorna uma String.
  String imcClassificacao(double value) {
    if (value < 16) {
      return 'Magreza gave';
    } else if (value >= 16 && value < 17) {
      return 'Magreza moderada';
    } else if (value >= 17 && value < 18.5) {
      return 'Magreza leve';
    } else if (value >= 18.5 && value < 25) {
      return 'Saudavel';
    } else if (value >= 25 && value < 30) {
      return 'Sobrepeso';
    } else if (value >= 30 && value < 35) {
      return 'Obesidade Grau 1';
    } else if (value > 35 && value < 40) {
      return 'Obesidade Grau 2 (severa)';
    } else {
      return 'Obesidade Grau 3 (morbida)';
    }
  }
}
