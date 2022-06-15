class LoadData {
  final String question;
  final String answers;
  final String correctIndex;

  LoadData({this.question, this.answers, this.correctIndex});

  factory LoadData.fromJson(Map<String, dynamic> json) {
    return LoadData(
      question: json['question'],
      answers: json['answers'],
      correctIndex: json['answers'],
    );
  }
}
