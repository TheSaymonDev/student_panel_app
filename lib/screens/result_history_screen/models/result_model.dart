import 'package:cloud_firestore/cloud_firestore.dart';

class ResultModel {
  String? id;
  String? subjectName;
  String? topicName;
  int? totalQuestions;
  int? correctAnswers;
  String? quizId;
  double? scorePercentage;
  Timestamp? createdAt;

  ResultModel({
    this.id,
    this.subjectName,
    this.topicName,
    this.totalQuestions,
    this.correctAnswers,
    this.quizId,
    this.scorePercentage,
    this.createdAt,
  });

  ResultModel.fromFireStore(Map<String, dynamic> json, String docId) {
    id = docId;
    subjectName = json['subjectName'];
    topicName = json['topicName'];
    totalQuestions = json['totalQuestions'];
    correctAnswers = json['correctAnswers'];
    quizId = json['quizId'];
    scorePercentage = json['scorePercentage'];
    createdAt = json['createdAt'];
  }
}
