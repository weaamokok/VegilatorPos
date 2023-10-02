// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Invoice {
 int? id ;
 double? totalAmount;
 String? dateRecorded;
 String? paymentType;
 int? userId;
  Invoice({
    required this.id,
    this.totalAmount,
    this.dateRecorded,
    this.paymentType,
    this.userId,
  });



  Invoice copyWith({
    int? id ,
    double? totalAmount,
    String? dateRecorded,
    String? paymentType,
    int? userId,
  }) {
    return Invoice(
     id :id  ?? this.id,
      totalAmount: totalAmount ?? this.totalAmount,
      dateRecorded: dateRecorded ?? this.dateRecorded,
      paymentType: paymentType ?? this.paymentType,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'totalAmount': totalAmount,
      'dateRecorded': dateRecorded,
      'paymentType': paymentType,
      'userId': userId,
    };
  }

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      id: map['id'] != null ? map['id'] as int : null,
      totalAmount: map['totalAmount'] != null ? map['totalAmount'] as double : null,
      dateRecorded: map['dateRecorded'] != null ? map['dateRecorded'] as String : null,
      paymentType: map['paymentType'] != null ? map['paymentType'] as String : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Invoice.fromJson(String source) => Invoice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Invoice(id: $id, totalAmount: $totalAmount, dateRecorded: $dateRecorded, paymentType: $paymentType, userId: $userId)';
  }

  @override
  bool operator ==(covariant Invoice other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.totalAmount == totalAmount &&
      other.dateRecorded == dateRecorded &&
      other.paymentType == paymentType &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      totalAmount.hashCode ^
      dateRecorded.hashCode ^
      paymentType.hashCode ^
      userId.hashCode;
  }
}
