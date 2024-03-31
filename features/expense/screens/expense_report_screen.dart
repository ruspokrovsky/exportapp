import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/constants/utils.dart';
import 'package:exportapp/features/expense/services/expense_report_service.dart';
import 'package:exportapp/widgets/custom_button.dart';
import 'package:exportapp/widgets/custom_textfield.dart';
import 'package:exportapp/widgets/loader.dart';
import 'package:flutter/material.dart';

class CreateExpenseReport extends StatefulWidget {
  static const String routeName = '/createExpenseReport';

  final Map<dynamic, dynamic> expenseDetails;

  const CreateExpenseReport({Key? key, required this.expenseDetails})
      : super(key: key);

  @override
  State<CreateExpenseReport> createState() => _CreateExpense();
}

class _CreateExpense extends State<CreateExpenseReport> {
  final ExpenseReportService expenseReportService = ExpenseReportService();
  final _createExpenseFormKey = GlobalKey<FormState>();

  List<File> images = [];
  String bankValue = 'Капиталбанк';
  String currencyValue = 'UZS';
  TextEditingController companyNameController = TextEditingController();
  TextEditingController agentNameController = TextEditingController();
  TextEditingController sumController = TextEditingController();
  TextEditingController freeCurrencyController = TextEditingController();
  TextEditingController paymentOrderController =
      TextEditingController(text: '1000');
  TextEditingController bankCommissionController =
      TextEditingController(text: '0.1');
  TextEditingController descriptionController = TextEditingController();

  bool isBankPayment = false;

  @override
  void dispose() {
    super.dispose();
    companyNameController.dispose();
    agentNameController.dispose();
    sumController.dispose();
    freeCurrencyController.dispose();
    paymentOrderController.dispose();
    bankCommissionController.dispose();
    descriptionController.dispose();
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  // void selectPdf() async {
  //   var res = await pickPdf();
  //   setState(() {
  //     images = res;
  //   });
  // }

  bool _isDownload = false;

  get isDownload => _isDownload;
  set isDownload(download){
    _isDownload = download;
  }

  void addReport() {


    //if (_createExpenseFormKey.currentState!.validate() && images.isNotEmpty) {

    if (_createExpenseFormKey.currentState!.validate()) {
      if (double.parse(widget.expenseDetails['expenseSum']) >=
          double.parse(sumController.text.trim())) {

        setState((){
          isDownload = true;
        });

        expenseReportService.expenseReport(
          context: context,
          expenseId: widget.expenseDetails['expenseId'],
          expenseSum: sumController.text.trim(),
          companyName: companyNameController.text.trim(),
          agentName: agentNameController.text.trim(),
          bankName: bankValue,
          currency: currencyValue,
          reportSum: sumController.text.trim(),
          freeCurrencyCost: freeCurrencyController.text.trim(),
          paymentOrder: paymentOrderController.text.trim(),
          bankCommission: bankCommissionController.text.trim(),
          description: descriptionController.text.trim(),
          images: images,
          reportDate: DateTime.now().millisecondsSinceEpoch,
          invoice: widget.expenseDetails['invoice'],
        ).then((value) => {
          if(value == "success"){

            setState((){
              isDownload = false;
            }),
            Navigator.pop(context)

          }
        });
      } else {
        showSnackBar(context, "Заданное значение превышает допусеимое");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(100, 150), //width and height
        // The size the AppBar would prefer if there were no other constraints.
        child: SafeArea(
          child: Card(
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Создать отчет",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Аванс №:"),
                      Text('${widget.expenseDetails['invoice']}'),
                    ],
                  ),
                  const Divider(
                    height: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Сумма аванса:"),
                      Text(widget.expenseDetails['expenseSum']),
                    ],
                  ),
                  const Divider(
                    height: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Дата оформления:"),
                      Text(GlobalVariables.dtFormat.format(
                          DateTime.fromMillisecondsSinceEpoch(
                              widget.expenseDetails['reportDate']))),
                    ],
                  ),
                  const Divider(
                    height: 0,
                  ),
                  Text(widget.expenseDetails['expenseId']),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _createExpenseFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: companyNameController,
                      textInputType: TextInputType.text,
                      hintText: 'Организация',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: agentNameController,
                      textInputType: TextInputType.text,
                      hintText: 'Агент',
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton(
                          value: bankValue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: GlobalVariables.bankItem.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              bankValue = newValue!;
                            });
                          },
                        ),
                        DropdownButton(
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: sumController,
                      textInputType: TextInputType.number,
                      hintText: 'Сумма',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: freeCurrencyController,
                      textInputType: TextInputType.number,
                      hintText: 'Свободный курс',
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                      "Платежное поручение: ${paymentOrderController.text} UZS"),
                                  Text(
                                      "Комиссия банка: ${bankCommissionController.text} %"),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  if (isBankPayment) {
                                    setState(() {
                                      isBankPayment = false;
                                    });
                                  } else {
                                    setState(() {
                                      isBankPayment = true;
                                    });
                                  }
                                },
                                icon: !isBankPayment
                                    ? const Icon(Icons.edit)
                                    : const Icon(Icons.clear)),
                          ],
                        ),
                        isBankPayment
                            ? Column(
                          children: [
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: paymentOrderController,
                              hintText: 'Платежное поручение',
                              textInputType: TextInputType.number,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: bankCommissionController,
                              hintText: 'Комиссия банка',
                              textInputType: TextInputType.number,
                            ),
                          ],
                        )
                            : Container(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    images.isNotEmpty
                        ? CarouselSlider(
                      items: images.map(
                            (i) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 200,
                      ),
                    )
                        : DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10, 4],
                      strokeCap: StrokeCap.round,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.folder_open,
                                    size: 40,
                                  ),
                                  onPressed: () {},
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Документы',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.image_search,
                                    size: 40,
                                  ),
                                  onPressed: selectImages,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Галерея',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: descriptionController,
                      textInputType: TextInputType.text,
                      hintText: 'Описание',
                      maxLines: 7,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            color: GlobalVariables.secondaryColor,
                            text: 'Сохранить',
                            onTap: addReport,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: CustomButton(
                            color: GlobalVariables.secondaryColor,
                            text: 'Отменить',
                            onTap: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
          _isDownload
          ?
          const Center(
            child: Loader(),
          )
              :
              Container(),


        ],
      )
    );
  }
}
