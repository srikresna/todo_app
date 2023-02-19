import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final void Function(bool) onCompleted;
  final void Function() onDelete;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.onCompleted,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      onDismissed: (direction) {
        onDelete();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Todo deleted'),
          duration: Duration(seconds: 2),
        ));
      },
      child: CheckboxListTile(
        value: todo.completed,
        title: Text(todo.title),
        onChanged: (value) => onCompleted(value!),
      ),
    );
  }
}
