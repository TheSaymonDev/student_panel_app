import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  String? id;
  String? topicName;
  String? timeDuration;
  String? endTime;
  List<QuestionModel>? questions;
  Timestamp? createdAt;
  String? subjectName;

  QuizModel({
    this.id,
    this.topicName,
    this.timeDuration,
    this.endTime,
    this.questions,
    this.createdAt,
    this.subjectName,
  });

  QuizModel.fromFireStore(Map<String, dynamic> json, String docId) {
    id = docId;
    topicName = json['topicName'];
    timeDuration = json['timeDuration'];
    endTime = json['endTime'];
    if (json['questions'] != null) {
      questions = <QuestionModel>[];
      json['questions'].forEach((v) {
        questions!.add(QuestionModel.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    subjectName = json['subjectName'];
  }
}

class QuestionModel {
  String? questionText;
  List<String>? options;
  int? correctAnswer;

  QuestionModel({this.questionText, this.options, this.correctAnswer});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    questionText = json['questionText'];
    options = json['options'].cast<String>();
    correctAnswer = json['correctAnswer'];
  }
}
