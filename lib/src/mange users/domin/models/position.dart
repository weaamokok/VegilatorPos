// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Position {
  int? id;
  String? title;
  Position({
    this.id,
    this.title,
  });

  Position copyWith({
    int? id,
    String? title,
  }) {
    return Position(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory Position.fromMap(Map<String, dynamic> map) {
    return Position(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Position.fromJson(String source) => Position.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Position(id: $id, title: $title)';

  @override
  bool operator ==(covariant Position other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
