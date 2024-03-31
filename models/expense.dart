import 'dart:convert';

class Expense {
  final String? id;
  final String userId;
  final String expenseSum;
  final String companyName;
  final String agentName;
  final String? bankName;
  final String? currency;
  final String reportSum;
  final String freeCurrencyCost;
  final String paymentOrder;
  final String bankCommission;
  final String description;
  final List<String> images;
  final int reportDate;
  final int? invoice;
  final int? status;

  Expense({
    this.id,
    required this.userId,
    required this.expenseSum,
    required this.companyName,
    required this.agentName,
    this.bankName,
    this.currency,
    required this.reportSum,
    required this.freeCurrencyCost,
    required this.paymentOrder,
    required this.bankCommission,
    required this.description,
    required this.images,
    required this.reportDate,
    this.invoice,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'expenseSum': expenseSum,
      'companyName': companyName,
      'agentName': agentName,
      'bankName': bankName,
      'currency': currency,
      'reportSum': reportSum,
      'freeCurrencyCost': freeCurrencyCost,
      'paymentOrder': paymentOrder,
      'bankCommission': bankCommission,
      'description': description,
      'images': images,
      'reportDate': reportDate,
      'invoice': invoice,
      'status': status,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
        id: map['_id'] ?? '',
        userId: map['userId'] ?? '',
        expenseSum: map['expenseSum'] ?? '',
        companyName: map['companyName'] ?? '',
        agentName: map['agentName'] ?? '',
        bankName: map['bankName'] ?? '',
        currency: map['currency'] ?? '',
        reportSum: map['reportSum'] ?? '',
        freeCurrencyCost: map['freeCurrencyCost'] ?? '',
        paymentOrder: map['paymentOrder'] ?? '',
        bankCommission: map['bankCommission'] ?? '',
        description: map['description'] ?? '',
        images: List<String>.from(map['images']),
        reportDate: map['reportDate'] ?? '',
        invoice: map['invoice'] ?? '',
        status: map['status'] ?? '',

    );
  }
  //
   String toJson() => json.encode(toMap());
  //
   factory Expense.fromJson(String source) => Expense.fromMap(json.decode(source));








  //
  // Expense copyWith(Map<String, dynamic> maps
  //   // String? id,
  //   // String? userId,
  //   // String? userName,
  //   // int   ? projectDate,
  //   // String? projectBank,
  //   // double? projectSum,
  //   // double? projectCommission,
  //   // double? amount,
  //   // String? currencyValue,
  //   // double? returnProject,
  //   // double? remainder,
  //   // int? status,
  // ) {
  //
  //
  //   return Expense(
  //     userId: maps['userId'] ?? userId,
  //     expenseSum: maps['expenseSum'] ?? expenseSum,
  //   );
  // }
}