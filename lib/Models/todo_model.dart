class Todo {
  final String id;
  final String title;
  final String description;
  final String category;
  final String date;
  final String? startTime;
  final String? endTime;
  final bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    this.startTime,
    this.endTime,
    this.isDone = false,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? date,
    String? startTime,
    String? endTime,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'isDone': isDone ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      date: map['date'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      isDone: map['isDone'] == 1,
    );
  }
}
