class Summ {
  final String name;
  List context = [];
  final List<String> summaries;

  Summ({
    required this.name,
    required this.summaries,
  });

  factory Summ.fromJson(Map<String, dynamic> json) {
    List<dynamic> summariesData = json['summaries'];

    return Summ(
      name: json['name'],
      summaries: List<String>.from(summariesData),
    );
  }
}
