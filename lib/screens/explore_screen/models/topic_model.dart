class TopicModel {
  List<QuestionModel>? questions;
  String? topicName;
  int? timeDuration;

  TopicModel({this.questions, this.topicName, this.timeDuration});

  TopicModel.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <QuestionModel>[];
      json['questions'].forEach((v) {
        questions!.add(QuestionModel.fromJson(v));
      });
    }
    topicName = json['topicName'];
    timeDuration = json['timeDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    data['topicName'] = topicName;
    data['timeDuration'] = timeDuration;
    return data;
  }
}

class QuestionModel {
  List<String>? options;
  int? correctAnswer;
  String? questionText;

  QuestionModel({this.options, this.correctAnswer, this.questionText});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    options = json['options'].cast<String>();
    correctAnswer = json['correctAnswer'];
    questionText = json['questionText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['options'] = options;
    data['correctAnswer'] = correctAnswer;
    data['questionText'] = questionText;
    return data;
  }
}
