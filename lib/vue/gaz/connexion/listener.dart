import 'package:flutter/material.dart ';


class ListenerCo extends ChangeNotifier{

  List _listVille = [];

  List get getListVille => _listVille;
  set setListVille(String l){
    _listVille.add(l) ;
    notifyListeners();
  }
}