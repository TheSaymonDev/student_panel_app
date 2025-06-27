import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? className;
  String? classCode;
  String? email;
  String? schoolName;
  Timestamp? joinedAt;

  UserModel({
    this.id,
    this.name,
    this.className,
    this.classCode,
    this.email,
    this.schoolName,
    this.joinedAt,
  });

  UserModel.fromFireStore(Map<String, dynamic> json, String docId) {
    id = docId;
    name = json['name'];
    className = json['className'];
    classCode = json['classCode'];
    email = json['email'];
    schoolName = json['schoolName'];
    joinedAt = json['joinedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['className'] = className;
    data['classCode'] = classCode;
    data['email'] = email;
    data['schoolName'] = schoolName;
    data['joinedAt'] = joinedAt;
    return data;
  }
}
