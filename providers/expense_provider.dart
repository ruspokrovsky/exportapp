import 'package:flutter/material.dart';
import 'package:exportapp/models/expense.dart';

class ExpenseProvider extends ChangeNotifier {

  final List<Expense> _expense = [];

  get expense => _expense;

  void addToList(Expense data) {
    _expense.add(data);
    notifyListeners();
  }

  void removeFromList(Expense data) {
    _expense.remove(data);
    notifyListeners();
  }

  void clearList() {
    _expense.clear();
    notifyListeners();
  }

  Expense _singleExpense = Expense(
    id: '',
    userId: '',
    expenseSum: '',
    companyName: '',
    agentName: '',
    reportSum: '',
    freeCurrencyCost: '',
    paymentOrder: '',
    bankCommission: '',
    description: '',
    images: [],
    reportDate: 0,
    invoice: 0,
    status: 0,
  );

  Expense get singleExpense => _singleExpense;

  void setExpense(String expense) {
    _singleExpense = Expense.fromJson(expense);
    notifyListeners();
  }

  void setExpenseFromModel(Expense expense) {
    _singleExpense = expense;
    notifyListeners();
  }
}