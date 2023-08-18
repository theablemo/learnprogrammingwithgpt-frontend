class Topic {
  final String name;
  final String explanation;
  List context = [];
  final List<String> examples;
  final List<String> exercise;

  Topic({
    required this.name,
    required this.explanation,
    required this.examples,
    required this.exercise,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    List<dynamic> examplesData = json['examples'];
    List<dynamic> exerciseData = json['exercise'];

    return Topic(
      name: json['name'],
      explanation: json['explanation'],
      examples: List<String>.from(examplesData),
      exercise: List<String>.from(exerciseData),
    );
  }
}
