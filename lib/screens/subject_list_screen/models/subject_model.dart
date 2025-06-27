import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectModel {
  String? id;
  String? subjectName;
  Timestamp? createdAt;

  SubjectModel(
      {this.id,
        this.subjectName,
        this.createdAt});

  SubjectModel.fromFireStore(Map<String, dynamic> json, String docId) {
    id = docId;
    subjectName = json['subjectName'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subjectName'] = subjectName;
    data['createdAt'] = createdAt;
    return data;
  }
}

