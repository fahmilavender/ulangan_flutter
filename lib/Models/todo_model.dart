class Todo {
  final String id; 
  final String title;
  final String description;
  final String category;
  final String date;
  final bool isDone;
  final String? startTime;
  final String? endTime;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.date = "Today",
    this.isDone = false,
    this.startTime,
    this.endTime,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? date,
    bool? isDone,
    String? startTime,
    String? endTime,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}

