import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício 06',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: CircleBorder(),
        ),
      ),
      home: const TasksPage(),
    );
  }
}

class Task {
  final String title;
  bool done;

  Task({required this.title, this.done = false});
}

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final List<Task> _tasks = List.generate(
    5,
    (index) => Task(
      title: 'Task ${DateTime.now().add(Duration(milliseconds: index * 450))}',
    ),
  );

  List<Task> get _pending => _tasks.where((task) => !task.done).toList();

  List<Task> get _completed => _tasks.where((task) => task.done).toList();

  void _toggle(Task task, bool? value) {
    setState(() => task.done = value ?? false);
  }

  Future<void> _openCompleted() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompletedTasksPage(
          tasks: _completed,
          onToggle: _toggle,
        ),
      ),
    );
    setState(() {});
  }

  void _showInfo() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notas de Tarefas'),
        content: const Text('Você está no App de Notas de Tarefas'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pending = _pending;
    return Scaffold(
      appBar: AppBar(title: const Text('Notas de Tarefas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: _openCompleted,
              child: const Text('View Completed Tasks'),
            ),
            const SizedBox(height: 16),
            Text('You have ${pending.length} uncompleted tasks'),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: pending.length,
                itemBuilder: (context, index) => TaskCard(
                  task: pending[index],
                  onChanged: (value) => _toggle(pending[index], value),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showInfo,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?> onChanged;

  const TaskCard({super.key, required this.task, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade300,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(task.title, style: const TextStyle(fontSize: 14)),
        trailing: Checkbox(value: task.done, onChanged: onChanged),
      ),
    );
  }
}

class CompletedTasksPage extends StatefulWidget {
  final List<Task> tasks;
  final void Function(Task task, bool? value) onToggle;

  const CompletedTasksPage({
    super.key,
    required this.tasks,
    required this.onToggle,
  });

  @override
  State<CompletedTasksPage> createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Completed Tasks')),
      body: widget.tasks.isEmpty
          ? const Center(child: Text('Nenhuma tarefa concluída'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.tasks.length,
              itemBuilder: (context, index) {
                final task = widget.tasks[index];
                return TaskCard(
                  task: task,
                  onChanged: (value) {
                    widget.onToggle(task, value);
                    setState(() {});
                  },
                );
              },
            ),
    );
  }
}
