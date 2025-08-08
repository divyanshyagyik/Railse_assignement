import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import 'widgets/task_card.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskController _controller = TaskController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _controller.tasks.length,
        itemBuilder: (context, index) {
          final task = _controller.tasks[index];
          return TaskCard(
            task: task,
            onStatusChanged: (taskId, newStatus) {
              setState(() {
                _controller.updateTaskStatus(taskId, newStatus);
              });
            },
            onDeadlineEdited: (task) async {
              await _controller.editDeadline(context, task);
              setState(() {});
            },
          );
        },
      ),
    );
  }
}