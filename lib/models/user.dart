import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String name;

  User(this.name);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<dynamic, dynamic> toJson() => _$UserToJson(this);

  factory User.fromFirestore(DocumentSnapshot documentSnapshot) {
    User user = User.fromJson(documentSnapshot.data);
    user.id = documentSnapshot.documentID;
    return user;
  }
}