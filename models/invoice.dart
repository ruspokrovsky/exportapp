import 'dart:convert';

class Invoice {
  final String? id;
  final int invoice;

  Invoice({
    this.id,
    required this.invoice,
  });

  Map<String, dynamic> toMap() {
    return {
      'invoice': invoice,
    };
  }

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
        id: map['_id'] ?? '',
        invoice: map['invoice'] ?? '',

    );
  }

   String toJson() => json.encode(toMap());

   factory Invoice.fromJson(String source) => Invoice.fromMap(json.decode(source));
}