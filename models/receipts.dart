import 'dart:convert';

class Receipts {
  final String id;
  final String userId;
  final String userName;
  final String sender;
  final int projectDate;
  final String projectBank;
  final String projectSum;
  final String projectCommission;
  final String amount;
  final String uzsSum;
  final String convertCost;
  final String currencyValue;
  final String returnProject;
  final String remainder;
  final int status;
  bool? isSelected;

  Receipts({
    required this.id,
    required this.userId,
    required this.userName,
    required this.sender,
    required this.projectDate,
    required this.projectBank,
    required this.projectSum,
    required this.projectCommission,
    required this.amount,
    required this.uzsSum,
    required this.convertCost,
    required this.currencyValue,
    required this.returnProject,
    required this.remainder,
    required this.status,
    this.isSelected,
  });

  Map<String, dynamic> toMap() {
    return {

    'id' : id,
    'userId' : userId,
    'userName' : userName,
    'sender' : sender,
    'projectDate' : projectDate,
    'projectBank' : projectBank,
    'projectSum' : projectSum,
    'projectCommission' : projectCommission,
    'amount' : amount,
    'uzsSum' : uzsSum,
    'convertCost' : convertCost,
    'currencyValue' : currencyValue,
    'returnProject' : returnProject,
    'remainder' : remainder,
    'status' : status,
    };
  }

  factory Receipts.fromMap(Map<String, dynamic> map) {
    return Receipts(

        id: map['_id'] ?? '',
        userId: map['userId'] ?? '',
        userName: map['userName'] ?? '',
        sender: map['sender'] ?? '',
        projectDate: map['projectDate'] ?? 0,
        projectBank: map['projectBank'] ?? '',
        projectSum: map['projectSum'] ?? '0.0',
        projectCommission: map['projectCommission'] ?? '0.0',
        amount: map['amount'] ?? '0.0',
        uzsSum: map['uzsSum'] ?? '0.0',
        convertCost: map['convertCost'] ?? '0.0',
        currencyValue: map['currencyValue'] ?? '',
        returnProject: map['returnProject'] ?? '0.0',
        remainder: map['remainder'] ?? '0.0',
        status: map['status'] ?? 0,

    );
  }

  String toJson() => json.encode(toMap());

  factory Receipts.fromJson(String source) => Receipts.fromMap(json.decode(source));

  Receipts copyWith(Map<String, dynamic> maps
    // String? id,
    // String? userId,
    // String? userName,
    // int   ? projectDate,
    // String? projectBank,
    // double? projectSum,
    // double? projectCommission,
    // double? amount,
    // String? currencyValue,
    // double? returnProject,
    // double? remainder,
    // int? status,
  ) {


    return Receipts(
      id: maps['id'] ?? id,
      userId: maps['userId'] ?? userId,
      userName: maps['userName'] ?? userName,
      sender: maps['sender'] ?? sender,
      projectDate: maps['projectDate'] ?? projectDate,
      projectBank: maps['projectBank'] ?? projectBank,
      projectSum: maps['projectSum'] ?? projectSum,
      projectCommission: maps['projectCommission'] ?? projectCommission,
      amount: maps['amount'] ?? amount,
      uzsSum: maps['uzsSum'] ?? uzsSum,
      convertCost: maps['uzsSum'] ?? convertCost,
      currencyValue: maps['currencyValue'] ?? currencyValue,
      returnProject: maps['returnProject'] ?? returnProject,
      remainder: maps['remainder'] ?? remainder,
      status: maps['status'] ?? status,
    );
  }
}