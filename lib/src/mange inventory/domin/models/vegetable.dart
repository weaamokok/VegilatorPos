// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Vegetable extends Equatable {
  final int? id;
  final String? name;
  final String? image; //I store the base64Encode of th Uint8list of the image
  final double? buyingPrizePerKg;
  final int? code;
  final int? catagoryId;
  final int? userId;
  final double? salePrizePerKg;
  const Vegetable({
    this.id,
    required this.name,
    this.image,
    this.buyingPrizePerKg,
    this.code,
    this.catagoryId,
    this.userId,
    this.salePrizePerKg,
  });
  
  @override
  List<Object?> get props {
    return [
      id,
      name,
      image,
      buyingPrizePerKg,
      code,
      catagoryId,
      userId,
      salePrizePerKg,
    ];
  }

  Vegetable copyWith({
    int? id,
    String? name,
    String? image,
    double? buyingPrizePerKg,
    int? code,
    int? catagoryId,
    int? userId,
    double? salePrizePerKg,
  }) {
    return Vegetable(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      buyingPrizePerKg: buyingPrizePerKg ?? this.buyingPrizePerKg,
      code: code ?? this.code,
      catagoryId: catagoryId ?? this.catagoryId,
      userId: userId ?? this.userId,
      salePrizePerKg: salePrizePerKg ?? this.salePrizePerKg,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'buyingPrizePerKg': buyingPrizePerKg,
      'code': code,
      'catagoryId': catagoryId,
      'userId': userId,
      'salePrizePerKg': salePrizePerKg,
    };
  }

  factory Vegetable.fromMap(Map<String, dynamic> map) {
    return Vegetable(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      buyingPrizePerKg: map['buyingPrizePerKg'] != null ? map['buyingPrizePerKg'] as double : null,
      code: map['code'] != null ? map['code'] as int : null,
      catagoryId: map['catagoryId'] != null ? map['catagoryId'] as int : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      salePrizePerKg: map['salePrizePerKg'] != null ? map['salePrizePerKg'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vegetable.fromJson(String source) => Vegetable.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
