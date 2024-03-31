import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/constants/utils.dart';
import 'package:exportapp/features/home/services/home_service.dart';
import 'package:exportapp/features/project/services/project_service.dart';
import 'package:exportapp/providers/user_provider.dart';
import 'package:exportapp/widgets/custom_button.dart';
import 'package:exportapp/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddProject extends StatefulWidget {
  static const String routeName = '/addProject';

  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {

  final ProjectService projectService = ProjectService();

  List<Map<String, dynamic>> projectList = [];

  final _addProjectFormKey = GlobalKey<FormState>();


  final TextEditingController _senderController = TextEditingController();
  final TextEditingController _sumController = TextEditingController();
  final TextEditingController _commissionController = TextEditingController();
  late TextEditingController _bankNameController = TextEditingController();

  String bankValue = 'Капиталбанк';
  String currencyValue = 'Валюта';

  @override
  void dispose() {
    super.dispose();
    _sumController.dispose();
    _commissionController.dispose();
    _bankNameController.dispose();
  }

  double _totalSum = 0.0;

  double get totalSum => _totalSum;

  set totalSum(project) {
    if (projectList.isNotEmpty) {
      _totalSum =
          projectList.map((e) => double.parse(e['projAmount'])).toList().reduce((v, e) => v + e);
    }
  }

  double _amountSum = 0.0;

  double get amountSum => _amountSum;

  set amountSum(map) {
    var percentSum = (map['sum'] * map['commission']) / 100;
    _amountSum = map['sum'] + percentSum;
  }

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<UserProvider>(context, listen: false).user.name;
    final userId = Provider.of<UserProvider>(context, listen: false).user.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создать проект", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _addProjectFormKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      DateFormat('dd.MM.yy/HH:MM').format(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                currencyValue != "Валюта" ? Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'total $currencyValue: ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: GlobalVariables.formatter.format(totalSum),
                            style: const TextStyle(
                              fontSize: 18,
                              color: GlobalVariables.warningColor,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            )),
                      ],
                    ),
                  ),
                )
                :
                Container(),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: _senderController,
                    textInputType: TextInputType.text,
                    hintText: "Отправитель"),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: _sumController,
                    textInputType: TextInputType.number,
                    hintText: "Сумма проекта"),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: _commissionController,
                    textInputType: TextInputType.number,
                    hintText: "Комиссия %"),
                const SizedBox(
                  height: 10,
                ),
                // CustomTextField(
                //     controller: _bankNameController,
                //     textInputType: TextInputType.text,
                //     hintText: "Банк"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton(
                      // Initial Value
                      value: bankValue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: GlobalVariables.bankItem.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),

                      onChanged: (String? newValue) {
                        bankValue = newValue!;
                        //print(newValue);
                        setState(() {
                          _bankNameController = TextEditingController(text: bankValue.toString());
                        });
                      },
                    ),
                    currencyValue == "Валюта" ? DropdownButton(
                      value: currencyValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: GlobalVariables.currencyItem.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          currencyValue = newValue!;
                        });
                      },
                    )
                    :
                    Container(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                          color: GlobalVariables.secondaryColor,
                          text: "Добавить",
                          onTap: () {
                            if (_addProjectFormKey.currentState!.validate()) {
                              createProjectArray(userId,userName);
                              totalSum = projectList;
                              setState(() {});
                            }
                          }),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomButton(
                          color: GlobalVariables.secondaryColor,
                          text: "Сохранить",
                          onTap: addProject
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Text(
                          "Банк",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: const Text(
                          "Сумма",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.start,
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 12,
                        child: const Text(
                          "%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: const Text(
                          "Всего",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.end,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                ListView.builder(
                  itemCount: projectList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                projectList[index]['projBank'],
                                style: const TextStyle(
                                    color: GlobalVariables.warningColor),
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Text(
                                GlobalVariables.formatter.format(double.parse(projectList[index]['projSum'])),
                                style: const TextStyle(
                                    color: GlobalVariables.warningColor),
                                //textAlign: TextAlign.end,
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 12,
                            child: Text(
                              '${projectList[index]['projCommission']}',
                              style: const TextStyle(
                                  color: GlobalVariables.warningColor),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text(
                              GlobalVariables.formatter.format(double.parse(projectList[index]['projAmount'])),
                              style: const TextStyle(
                                  color: GlobalVariables.warningColor),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        projectList.removeAt(index);
                        setState(() {});
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh(context) async {
    await HomeServices().fetchAllProjects(context);
    setState(() {});
  }

  void addProject() {
    projectService.addProject(
      context: context,
      projectArray: projectList,
    ).then((value) => {

      if(value == "success"){
        _onRefresh(context),
        Navigator.of(context).pop()
      }

    });
  }

  void createProjectArray(userId,userName) {
    if (currencyValue != 'Валюта') {
      amountSum = {
        'sum': double.parse(_sumController.text.replaceAll(',', '.')),
        'commission': double.parse(_commissionController.text.replaceAll(',', '.'))
      };
      projectList.add({
        'userId': userId,
        'userName': userName,
        'projSender': _senderController.text.trim(),
        'projDate': DateTime.now().millisecondsSinceEpoch,
        'projBank': bankValue,
        'projSum': _sumController.text.trim().replaceAll(',', '.'),
        'projCommission': _commissionController.text.trim().replaceAll(',', '.'),
        'projAmount': amountSum.toString(),
        'projUzsSum': '0.0',
        'convertCost': '0.0',
        'currencyValue': currencyValue,
        'projDebtRepayment': '0.0',
        'projBalance': amountSum.toString(),
      });
    } else {
      showSnackBar(context, "Уточните валюту");
    }
  }
}
