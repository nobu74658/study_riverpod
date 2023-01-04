import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class Todo {
  const Todo(
      {required this.id, required this.description, required this.completed});

  final String id;
  final String description;
  final bool completed;

  Todo copyWith({String? id, String? description, bool? completed}) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}

// class TodosNotifier extends StateNotifier<List<Todo>> {
//   TodosNotifier() : super([]);
//
//   void addTodo(Todo todo) {
//     state = [...state, todo];
//   }
//
//   void removeTodo(String todoId) {
//     state = [
//       for (final todo in state)
//         if (todo.id != todoId) todo,
//     ];
//   }
//
//   void toggle(String todoId) {
//     state = [
//       for (final todo in state)
//         if (todo.id == todoId)
//           todo.copyWith(completed: !todo.completed)
//       else
//         todo,
//     ];
//   }
// }

// final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
//   return TodosNotifier();
// });

class TodoListView extends ConsumerWidget {
  const TodoListView({required this.todos, Key? key}) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // List<Todo> todos = ref.watch(todosProvider("hogehogehoge"));

    return ListView(
      children: [
        for (final todo in todos)
          CheckboxListTile(
            value: todo.completed,
            onChanged: (value) =>
                ref.read(todosProvider("21").notifier).removeTodo(todo.id),
            title: Text(todo.description),
          )
      ],
    );
  }
}

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier({
    required this.text,
  }) : super([]) {
    print(text);
    addTodo(Todo(id: '21', description: text, completed: false));
  }

  final String text;

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(String todoId) {
    print(todoId);
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo
    ];
  }

  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(completed: !todo.completed)
        else
          todo,
    ];
  }
}

final todosProvider =
    StateNotifierProvider.family<TodosNotifier, List<Todo>, String>(
        (ref, text) {
  return TodosNotifier(text: text);
});
