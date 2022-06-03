class Person {
  String? id;
  String name;
  int document;

  Person({
    this.id,
    required this.name,
    required this.document,
  });

  @override
  String toString() {
    return "$id | $name | $document ";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> object = Map<String, dynamic>();

    object['name'] = name;
    object['document'] = document;

    return object;
  }

  factory Person.fromJson(Map<String, dynamic> json) =>
      Person(id: json['id'], name: json['name'], document: json['document']);
}
