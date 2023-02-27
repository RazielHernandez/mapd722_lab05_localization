
class Task {
  String id;
  String title;
  String description;
  String category;
  bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'status': isDone
    };
  }

  @override
  String toString() {
    return 'Task{id: $id, name: $title, description: $description, category: $category, status: $isDone}';
  }
}