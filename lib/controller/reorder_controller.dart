import 'package:flutter/material.dart';

///Manages enabling/disabling the reordering of playlists
class ReorderController extends ChangeNotifier {
  bool canReorder = false;

  ///Enables playlist reordering
  void enable() {
    canReorder = true;
    notifyListeners();
  }

  ///Disables playlist reordering
  void disable() {
    canReorder = false;
    notifyListeners();
  }

  //__ Singleton
  static final ReorderController _instance = ReorderController._();
  factory ReorderController() => _instance;
  ReorderController._();
}
