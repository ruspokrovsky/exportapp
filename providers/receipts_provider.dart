import 'package:exportapp/models/project.dart';
import 'package:exportapp/models/receipts.dart';
import 'package:flutter/material.dart';

class ReceiptsProvider with ChangeNotifier{

  final List<Project> _project = [];

  get project => _project;

  void addToList(Project data) {
    _project.add(data);
    notifyListeners();
  }

  void removeFromList(Project data) {
    _project.remove(data);
    notifyListeners();
  }

  void clearList() {
    _project.clear();
    notifyListeners();
  }

  Receipts _singleReceipts = Receipts(
    id: '',
    userId: '',
    userName: '',
    sender: '',
    projectDate: 0,
    projectBank: '',
    projectSum: '0.0',
    projectCommission: '0.0',
    amount: '0.0',
    uzsSum: '0.0',
    convertCost: '0.0',
    currencyValue: '',
    returnProject: '0.0',
    remainder: '0.0',
    status: 0,
  );

  Receipts get receipts => _singleReceipts;

  void setReceipts(String project) {
    _singleReceipts = Receipts.fromJson(project);
    notifyListeners();
  }
}