class TodoItem {
  int id;
  String description;
  bool isDone;

  TodoItem({required this.id, required this.description, this.isDone = false});
}
