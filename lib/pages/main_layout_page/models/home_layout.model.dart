import 'package:flutter/material.dart';

import 'apartment.model.dart';

class HomeLayoutModel with ChangeNotifier {
  late PageController _controller;

  PageController get controller => _controller;

  set controller(PageController controller) {
    _controller = controller;
    notifyListeners();
  }

  Apartment? _selectedApartment;

  Apartment? get selectedApartment => _selectedApartment;

  set selectedApartment(Apartment? selectedApartment) {
    _selectedApartment = selectedApartment;
    notifyListeners();
  }

  int _selectedNavigationIndex = 0;

  int get selectedNavigationIndex => _selectedNavigationIndex;

  set selectedNavigationIndex(int index) {
    _selectedNavigationIndex = index;
    notifyListeners();
  }
}