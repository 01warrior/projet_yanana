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

  bool _dispoOryx6 = false;
  bool _dispoOryx12 = false;
  bool _dispoTotal12 = false;
  bool _dispoTotal6 = false;
  bool _dispoPegaz12 = false;
  bool _dispoPegaz6 = false;
  bool _dispoSodigaz12 = false;
  bool _dispoSodigaz6 = false;

  bool _vendOryx = false;
  bool _vendTotal = false;
  bool _vendPegaz = false;
  bool _vendSodigaz = false;
  List _listGazVendu = [];
  List<String> _listGazDispo =  [];

  List get getListGazVendu => _listGazVendu;
  List get getListGazDispo => _listGazDispo;

  bool get getDispoOryx6 => _dispoOryx6;
  set setDispoOryx6(bool d){
    _dispoOryx6 = d;
    notifyListeners();
  }
  
  bool get getVendOryx => _vendOryx;
  set setVendOryx(bool v){
    _vendOryx = v;
    notifyListeners();
  }
  bool get getVendTotal => _vendTotal;
  set setVendTotal(bool v){
    _vendTotal = v;
    notifyListeners();
  }
  bool get getVendPegaz => _vendPegaz;
  set setVendPegaz(bool v){
    _vendPegaz = v;
    notifyListeners();
  }
  bool get getVendSodigaz => _vendSodigaz;
  set setVendSodigaz(bool v){
    _vendSodigaz = v;
    notifyListeners();
  }


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