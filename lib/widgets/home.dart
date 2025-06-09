import 'package:flutter/material.dart';
import 'package:tarea7/bloc/todo_bloc.dart';
import 'package:tarea7/clases/todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TodoBloc _bloc = TodoBloc();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _bloc.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      _bloc.addTask(_controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do Stream')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _controller)),
                IconButton(icon: const Icon(Icons.add), onPressed: _addTask),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Todo>>(
              stream: _bloc.todoStream,
              initialData: const [],
              builder: (context, snapshot) {
                final todos = snapshot.data!;
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return ListTile(
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.completed
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      leading: Checkbox(
                        value: todo.completed,
                        onChanged: (_) => _bloc.toggleComplete(index),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _bloc.removeTask(index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
