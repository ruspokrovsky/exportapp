import 'dart:convert';

class Project {
  final String id;
  final String userId;
  final String userName;
  final String projSender;
  final int projDate;
  final String projBank;
  final String projSum;
  final String projCommission;
  final String projAmount;
  final String projUzsSum;
  final String convertCost;
  final String currencyValue;
  final String projDebtRepayment;
  final String projBalance;
  final int projStatus;
  bool? isSelected;

  Project({
    required this.id,
    required this.userId,
    required this.userName,
    required this.projSender,
    required this.projDate,
    required this.projBank,
    required this.projSum,
    required this.projCommission,
    required this.projAmount,
    required this.projUzsSum,
    required this.convertCost,
    required this.currencyValue,
    required this.projDebtRepayment,
    required this.projBalance,
    required this.projStatus,
    this.isSelected,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'projSender': projSender,
      'projectDate': projDate,
      'projectBank': projBank,
      'projectSum': projSum,
      'projectCommission': projCommission,
      'projAmount': projAmount,
      'projUzsSum': projUzsSum,
      'convertCost': convertCost,
      'currencyValue': currencyValue,
      'projDebtRepayment': projDebtRepayment,
      'projBalance': projBalance,
      'projStatus': projStatus,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['_id'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      projSender: map['projSender'] ?? '',
      projDate: map['projDate'] ?? 0,
      projBank: map['projBank'] ?? '',
      projSum: map['projSum'] ?? '0.0',
      projCommission: map['projCommission'] ?? '0.0',
      projAmount: map['projAmount'] ?? '0.0',
      projUzsSum: map['projUzsSum'] ?? '0.0',
      convertCost: map['convertCost'] ?? '0.0',
      currencyValue: map['currencyValue'] ?? '',
      projDebtRepayment: map['projDebtRepayment'] ?? '0.0',
      projBalance: map['projBalance'] ?? '0.0',
      projStatus: map['projStatus'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source));

  Project copyWith(Map<String, dynamic> maps
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
    return Project(
      id: maps['id'] ?? id,
      userId: maps['userId'] ?? userId,
      userName: maps['userName'] ?? userName,
      projSender: maps['projSender'] ?? projSender,
      projDate: maps['projDate'] ?? projDate,
      projBank: maps['projBank'] ?? projBank,
      projSum: maps['projSum'] ?? projSum,
      projCommission: maps['projCommission'] ?? projCommission,
      projAmount: maps['projAmount'] ?? projAmount,
      projUzsSum: maps['projUzsSum'] ?? projUzsSum,
      convertCost: maps['uzsSum'] ?? convertCost,
      currencyValue: maps['currencyValue'] ?? currencyValue,
      projDebtRepayment: maps['projDebtRepayment'] ?? projDebtRepayment,
      projBalance: maps['projBalance'] ?? projBalance,
      projStatus: maps['projStatus'] ?? projStatus,
    );
  }
}
