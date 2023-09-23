import 'package:flutter/material.dart';

class ReorderService extends ChangeNotifier {
  //Singleton
  static final ReorderService _instance = ReorderService._();
  factory ReorderService() => _instance;
  ReorderService._();

  bool canReorder = false;

  void enable() {
    canReorder = true;
    notifyListeners();
  }

  void disable() {
    canReorder = false;
    notifyListeners();
  }
}
