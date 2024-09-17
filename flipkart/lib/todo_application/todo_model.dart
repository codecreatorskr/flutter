class TodoModel {
  dynamic id;
  final String title;
  final String body;

  TodoModel({
    this.id = '',
    required this.title,
    required this.body,
  });

//Convert Map to String
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  //Convert String to map

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
