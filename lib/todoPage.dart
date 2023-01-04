import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/todo.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: TodoListView(todos: ref.watch(todosProvider("nhvewoabvnwa")),),
      floatingActionButton: FloatingActionButton(onPressed: () {
        ref.read(todosProvider("hoge2").notifier).addTodo(Todo(id: "1", description: 'hogehoge', completed: false));
      }),
    );
  }
}
