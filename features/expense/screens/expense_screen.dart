import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/features/expense/services/expense_service.dart';
import 'package:exportapp/features/expense/widgets/new_expense.dart';
import 'package:exportapp/features/expense/widgets/success_expense.dart';
import 'package:exportapp/models/expense.dart';
import 'package:exportapp/providers/expense_provider.dart';
import 'package:exportapp/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatefulWidget {
  static const routeName = '/expenseScreen';

  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  int _selectedIndex = 0;
  List<Expense>? expense;
  double _totalExpense = 0.0;

  @override
  void initState() {
    fetchAllExpense();
    super.initState();
  }

  Future<void> _onRefresh() async {
    await ExpenseServices().fetchAllExpense(context);
    setState(() {});
    return Future<void>.delayed(const Duration(seconds: 0));
  }

  fetchAllExpense() async {
    await ExpenseServices().fetchAllExpense(context);
    setState(() {});
  }

  get totalExpense => _totalExpense;

  set totalExpense(totalExpense) {
    _totalExpense = totalExpense;
  }

  @override
  Widget build(BuildContext context) {
    var expenseFromProvider = context.watch<ExpenseProvider>();
    setState(() {
      expense = expenseFromProvider.expense;
    });
    if (expense!.isNotEmpty) {
      totalExpense = expense!
          .map((e) => e.status == 0 ? double.parse(e.expenseSum) : 0.0)
          .toList()
          .reduce((v, e) => v + e);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: _selectedIndex == 0
          ?
        const Size.fromHeight(95.0)
        :
        const Size.fromHeight(50.0),

        child: AppBar(
          //automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  _selectedIndex == 0
                      ? Column(
                          children: [
                            const Text(
                              "АВАНСЫ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Всего UZS:',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  GlobalVariables.formatter
                                      .format(totalExpense),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        )
                      : const Text(
                          "ЗАКРЫТЫЕ АВАНСЫ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: expense == null
            ? const Loader()
            : _selectedIndex == 0
                ? NewExpense(expense!)
                : _selectedIndex == 1
                    ? SuccessExpense(expense!)
                    : Container(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outline_blank),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
