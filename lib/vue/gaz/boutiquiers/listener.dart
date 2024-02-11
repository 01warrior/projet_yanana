import 'package:flutter/material.dart';

class ListenerBoutiq extends ChangeNotifier{

  int _qteOryx6 = 0;
  int _qteOryx12 = 0;
  int _qteTotal6 = 0;
  int _qteTotal12 = 0;
  int _qtePegaz6 = 0;
  int _qtePegaz12 = 0;
  int _qteSodigaz6 = 0;
  int _qteSodigaz12 = 0;
  bool _nonRecupData = true;

  bool get getNonRecupData => _nonRecupData;
  set setNonRecupData(bool r){
    _nonRecupData = r;
    notifyListeners();
  }
  int get getQteOryx6 => _qteOryx6;
  set setQteOryx6(int q){
    _qteOryx6 = q;
    notifyListeners();
  }

  int get getQteOryx12 => _qteOryx12;
  set setQteOryx12(int q){
    _qteOryx12 = q;
    notifyListeners();
  }

  int get getQteTotal6 => _qteTotal6;
  set setQteTotal6(int q){
    _qteTotal6 = q;
    notifyListeners();
  }

  int get getQteTotal12 => _qteTotal12;
  set setQteTotal12(int q){
    _qteTotal12 = q;
    notifyListeners();
  }

  int get getQtePegaz6 => _qtePegaz6;
  set setQtePegaz6(int q){
    _qtePegaz6 = q;
    notifyListeners();
  }

  int get getQtePegaz12 => _qtePegaz12;
  set setQtePegaz12(int q){
    _qtePegaz12 = q;
    notifyListeners();
  }

  int get getQteSodigaz6 => _qteSodigaz6;
  set setQteSodigaz6(int q){
    _qteSodigaz6 = q;
    notifyListeners();
  }

  int get getQteSodigaz12 => _qteSodigaz12;
  set setQteSodigaz12(int q){
    _qteSodigaz12 = q;
    notifyListeners();
  }
}