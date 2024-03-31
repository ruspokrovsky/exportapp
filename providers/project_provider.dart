import 'package:flutter/material.dart';
import 'package:exportapp/models/project.dart';



class ProjectProvider extends ChangeNotifier {
  Project _project = Project(
    id: '',
    userId: '',
    userName: '',
    projSender: '',
    projDate: 0,
    projBank: '',
    projSum: '0.0',
    projCommission: '0.0',
    projAmount: '0.0',
    projUzsSum: '0.0',
    convertCost: '0.0',
    currencyValue: '',
    projDebtRepayment: '0.0',
    projBalance: '0.0',
    projStatus: 0,
  );

  Project get project => _project;

  void setProject(String project) {
    _project = Project.fromJson(project);
    notifyListeners();
  }

  void setProjectFromModel(Project project) {
    _project = project;
    notifyListeners();
  }
}