// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Sale {
  int? id;
  double? subTotal;
  double? unitPrice;
  int? vegeId;
  int? invoiceId;
  int? quantity;
  Sale({
    this.id,
    this.subTotal,
    this.unitPrice,
    this.vegeId,
    this.invoiceId,
    this.quantity,
  });

  

  Sale copyWith({
    int? id,
    double? subTotal,
    double? unitPrice,
    int? vegeId,
    int? invoiceId,
    int? quantity,
  }) {
    return Sale(
      id: id ?? this.id,
      subTotal: subTotal ?? this.subTotal,
      unitPrice: unitPrice ?? this.unitPrice,
      vegeId: vegeId ?? this.vegeId,
      invoiceId: invoiceId ?? this.invoiceId,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'subTotal': subTotal,
      'unitPrice': unitPrice,
      'vegeId': vegeId,
      'invoiceId': invoiceId,
      'quantity': quantity,
    };
  }

  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map['id'] != null ? map['id'] as int : null,
      subTotal: map['subTotal'] != null ? map['subTotal'] as double : null,
      unitPrice: map['unitPrice'] != null ? map['unitPrice'] as double : null,
      vegeId: map['vegeId'] != null ? map['vegeId'] as int : null,
      invoiceId: map['invoiceId'] != null ? map['invoiceId'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sale.fromJson(String source) => Sale.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Sale(id: $id, subTotal: $subTotal, unitPrice: $unitPrice, vegeId: $vegeId, invoiceId: $invoiceId, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant Sale other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.subTotal == subTotal &&
      other.unitPrice == unitPrice &&
      other.vegeId == vegeId &&
      other.invoiceId == invoiceId &&
      other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      subTotal.hashCode ^
      unitPrice.hashCode ^
      vegeId.hashCode ^
      invoiceId.hashCode ^
      quantity.hashCode;
  }
}
