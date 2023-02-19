import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/provider/todo_provider.dart';
import 'package:todo/screens/todo_screen.dart';

void main() {
  testWidgets('Test add todo', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => TodoProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: TodoScreen(),
        ),
      ),
    );

    final textFieldFinder = find.byType(TextField);
    final addButtonFinder = find.byIcon(Icons.add);

    expect(textFieldFinder, findsOneWidget);
    expect(addButtonFinder, findsOneWidget);

    // Input todo title
    await tester.enterText(textFieldFinder, 'My new todo');

    // Tap add button
    await tester.tap(addButtonFinder);
    await tester.pump();

    // Verify that the new todo is added to the list
    final todoProvider = Provider.of<TodoProvider>(tester.element(find.byType(TodoScreen)));
    final todos = todoProvider.todos;
    final addedTodo = todos.firstWhere((todo) => todo.title == 'My new todo');
    expect(addedTodo, isNotNull);
  });
}
