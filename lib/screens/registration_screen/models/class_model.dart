import 'package:cloud_firestore/cloud_firestore.dart';

class ClassModel {
  String? id;
  String? className;
  Timestamp? createdAt;

  ClassModel({
    this.id,
    this.className,
    this.createdAt,
  });

  ClassModel.fromFireStore(Map<String, dynamic> json, String docId) {
    id = docId;
    className = json['className'];
    createdAt = json['createdAt'];
  }

}
