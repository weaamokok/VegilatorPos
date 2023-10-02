// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Catagory {
int? id;
String? catagory;
  Catagory({
    this.id,
    this.catagory,
  });


  Catagory copyWith({
    int? id,
    String? catagory,
  }) {
    return Catagory(
      id: id ?? this.id,
      catagory: catagory ?? this.catagory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'catagory': catagory,
    };
  }

  factory Catagory.fromMap(Map<String, dynamic> map) {
    return Catagory(
      id: map['id'] != null ? map['id'] as int : null,
      catagory: map['catagory'] != null ? map['catagory'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Catagory.fromJson(String source) => Catagory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Catagory(id: $id, catagory: $catagory)';

  @override
  bool operator ==(covariant Catagory other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.catagory == catagory;
  }

  @override
  int get hashCode => id.hashCode ^ catagory.hashCode;
}
