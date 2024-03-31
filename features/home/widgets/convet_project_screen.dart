import 'dart:math';

import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/constants/utils.dart';
import 'package:exportapp/features/expense/services/expense_service.dart';
import 'package:exportapp/features/expense/widgets/expense_dialog_content.dart';
import 'package:exportapp/features/home/services/home_service.dart';
import 'package:exportapp/features/project/services/project_service.dart';
import 'package:exportapp/models/expense.dart';
import 'package:exportapp/models/invoice.dart';
import 'package:exportapp/models/project.dart';
import 'package:exportapp/providers/expense_provider.dart';
import 'package:exportapp/providers/text_field_provider.dart';
import 'package:exportapp/providers/user_provider.dart';
import 'package:exportapp/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversionProjectScreen extends StatefulWidget {
  final List projects;
  final List<Expense> expense;

  const ConversionProjectScreen(List<Project> this.projects, this.expense,
      {Key? key})
      : super(key: key);

  @override
  State<ConversionProjectScreen> createState() =>
      _ConversionProjectScreenState();
}

class _ConversionProjectScreenState extends State<ConversionProjectScreen> {
  ProjectService projectService = ProjectService();
  ExpenseServices expenseServices = ExpenseServices();
  TextEditingController repaymentController = TextEditingController();

  List<Invoice>? allInvoice;
  late int invoiceNum;
  List list = [];
  String expenseSum = "";
  double _totalUzs = 0.0;
  double _totalExpense = 0.0;
  double _freeUzs = 0.0;

  get totalUzs => _totalUzs;

  set totalUzs(totalUzs) {
    _totalUzs = totalUzs;
  }

  get totalExpense => _totalExpense;

  set totalExpense(totalExpense) {
    _totalExpense = totalExpense;
  }

  get freeUzs => _freeUzs;

  set freeUzs(freeUzs) {
    _freeUzs = freeUzs;
  }

  double _debtRepaymentSum(projDebtRepayment, projBalance, editReturnSum) {
    double result = (double.parse(projBalance) - double.parse(editReturnSum));
    return result;
  }

  Future<void> _onRefresh(context) async {
    await HomeServices().fetchAllProjects(context);
    await ExpenseServices().fetchAllExpense(context);
    setState(() {});
  }

  Future _addRepayment(String id, String projAmount,
      String newProjDebtRepayment, String newProjBalance) async {
    String isSuccess = "";

    if (repaymentController.text.isNotEmpty) {
      if (double.parse(projAmount) >= double.parse(newProjDebtRepayment)) {
        await projectService
            .addRepayment(
              context: context,
              projectId: id,
              debtRepayment: newProjDebtRepayment,
              projBalance: newProjBalance,
            )
            .then((value) => {
                  if (value == "success")
                    {isSuccess = "success"}
                  else
                    {isSuccess = "field"}
                });
      } else {
        showSnackBar(context, "заданное значение превышает допустимое");
      }
    } else {
      showSnackBar(context, "Пустое поле");
    }

    return isSuccess;
  }

  Future _createExpense(String userId, int invoiceNum) async {
    await expenseServices.createExpense(
        context: context,
        userId: userId,
        expenseSum: expenseSum,
        companyName: 'companyName',
        agentName: 'agentName',
        reportSum: 'reportSum',
        currency: 'currency',
        freeCurrencyCost: 'freeCurrencyCost',
        paymentOrder: 'paymentOrder',
        bankCommission: 'bankCommission',
        description: 'description',
        images: [],
        reportDate: DateTime.now().millisecondsSinceEpoch,
        invoice: invoiceNum,
        status: 0,
    );

    return "success";
  }

  @override
  Widget build(BuildContext context) {

    expenseSum = context.watch<TextFieldProvider>().resultString.replaceAll(',', '.');
    String userId = context.watch<UserProvider>().user.id;
    List expenseFromProvider = context.watch<ExpenseProvider>().expense;

    if (widget.projects.isNotEmpty) {
      totalUzs = widget.projects
          .map((e) => e.projStatus == 1 ? double.parse(e.projUzsSum) : 0.0)
          .toList()
          .reduce((v, e) => v + e);
    }

    if (widget.expense.isNotEmpty) {
      totalExpense = expenseFromProvider
          .map((e) => e.status == 0 ? double.parse(e.expenseSum) : 0.0)
          .toList()
          .reduce((v, e) => v + e);
    }


    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Всего сумма:",
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    GlobalVariables.formatter.format(totalUzs),
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Сумма авнсов:",
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    GlobalVariables.formatter.format(totalExpense),
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Свободная сумма:",
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    GlobalVariables.formatter.format(totalUzs - totalExpense),
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              CustomButton(
                  color: GlobalVariables.secondaryColor,
                  text: "Создать аванс",
                  onTap: () {
                    ExpenseServices()
                        .fetchActualInvoice(context)
                        .then((value) => {
                              invoiceNum = value + 1,
                              dialog(context, "Создать аванс",
                                  DialogContent(totalUzs), () {
                                _createExpense(userId, invoiceNum)
                                    .then((value) => {
                                          if (value == "success")
                                            {
                                              Navigator.of(context).pop()}
                                        });
                              })
                            });
                  })
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              //reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemCount: widget.projects.length,
              itemBuilder: (context, index) {
                if (widget.projects[index].isSelected == null) {
                  widget.projects[index].isSelected = false;
                }
                return widget.projects[index].projStatus == 1
                    ? Card(
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Отправитель:"),
                                  Text(widget.projects[index].projSender),
                                ],
                              ),
                              const Divider(
                                height: 0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Банк:"),
                                  Text(widget.projects[index].projBank),
                                ],
                              ),
                              const Divider(
                                height: 0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Сумма:"),
                                  Text(
                                      '${GlobalVariables.formatter.format(double.parse(widget.projects[index].projSum))} ${widget.projects[index].currencyValue}'),
                                ],
                              ),
                              const Divider(
                                height: 0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Комиссия:"),
                                  Text(
                                      '${widget.projects[index].projCommission} %'),
                                ],
                              ),
                              const Divider(
                                height: 0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Всего:"),
                                  Text(
                                      '${GlobalVariables.formatter.format(double.parse(widget.projects[index].projAmount))} ${widget.projects[index].currencyValue}'),
                                ],
                              ),
                              const Divider(
                                height: 0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Погашение"),
                                  Text(
                                      '${GlobalVariables.formatter.format(double.parse(widget.projects[index].projDebtRepayment))} ${widget.projects[index].currencyValue}'),
                                ],
                              ),
                              const Divider(
                                height: 0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Остаток:"),
                                  Text(
                                      '${GlobalVariables.formatter.format(double.parse(widget.projects[index].projBalance))} ${widget.projects[index].currencyValue}'),
                                ],
                              ),
                              const Divider(
                                height: 0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Курс конвертации:"),
                                  Text('${widget.projects[index].convertCost}'),
                                ],
                              ),
                              const Divider(
                                height: 0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Сумма UZS:"),
                                  Text(GlobalVariables.formatter.format(
                                      double.parse(
                                          widget.projects[index].projUzsSum))),
                                ],
                              ),
                              const Divider(
                                height: 0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Дата транзакции:"),
                                  Text(GlobalVariables.dtFormat.format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          widget.projects[index].projDate))),
                                ],
                              ),
                              const Divider(
                                height: 0,
                              ),
                              Text(
                                'id:${widget.projects[index].id}',
                                style: const TextStyle(
                                    color: GlobalVariables.lightColor),
                              ),
                              const Divider(
                                height: 0,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              widget.projects[index].isSelected
                                  ? TextField(
                                      controller: repaymentController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: "Сумма погашения",
                                          prefixIcon: InkWell(
                                            onTap: () {
                                              if (repaymentController.text != "") {
                                                String newProjDebtRepayment = "";
                                                String newProjBalance = "";

                                                newProjBalance = _debtRepaymentSum( widget.projects[index] .projDebtRepayment,
                                                        widget.projects[index] .projBalance,
                                                        repaymentController.text .trim().replaceAll(',', '.')).toString();

                                                newProjDebtRepayment = (
                                                    double.parse(repaymentController.text.trim().replaceAll(',', '.')) + double.parse(widget.projects[index].projDebtRepayment)).toString();

                                                _addRepayment(widget.projects[index].id,
                                                        widget.projects[index].projAmount,
                                                        newProjDebtRepayment,
                                                        newProjBalance)
                                                    .then((value) => {
                                                          if (value ==
                                                              "success")
                                                            {
                                                              _onRefresh(context),
                                                              setState(() {
                                                                repaymentController.text = "";
                                                                widget.projects[index].isSelected = false;
                                                              })
                                                            }
                                                        });
                                              } else {
                                                showSnackBar(
                                                    context, "Пустое поле");
                                              }
                                            },
                                            child: const Icon(
                                              Icons.send,
                                              color: GlobalVariables
                                                  .secondaryColor,
                                            ),
                                          )),
                                      onChanged: (String value) async {})
                                  : Container(),
                            ],
                          ),
                          onLongPress: () {
                            if (widget.projects[index].isSelected) {
                              widget.projects[index].isSelected = false;

                              setState(() {});
                            } else {
                              widget.projects[index].isSelected = true;
                              repaymentController.text = "";
                              setState(() {});
                            }
                          },
                        ),
                      )
                    : Container();
              }),
        ),
      ],
    );
  }
}
