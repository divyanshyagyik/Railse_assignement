import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskController {
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Complete Flutter Assignment 1',
      description: 'Build Interactive UI',
      assignedTo: 'Rakesh',
      deadline: DateTime.now().add(const Duration(hours: 2)),
      status: TaskStatus.notStarted,
    ),
    Task(
      id: '2',
      title: 'Complete Flutter Assignment 2',
      description: 'Complete Firebase Integration',
      assignedTo: 'Anuj',
      deadline: DateTime.now().subtract(const Duration(hours: 1)),
      status: TaskStatus.started,
    ),
    Task(
      id: '3',
      title: 'Complete Flutter Assignment 3',
      description: 'Integrate Google Admob',
      assignedTo: 'Ajay',
      deadline: DateTime.now().add(const Duration(days: 3)),
      status: TaskStatus.completed,
    ),
    Task(
      id: '4',
      title: 'Complete Flutter Assignment 4',
      description: 'Integrate Razorpay Payment Gateway',
      assignedTo: 'Ayush',
      deadline: DateTime.now().add(const Duration(days: 5)),
      status: TaskStatus.notStarted,
    ),
  ];

  List<Task> get tasks => _tasks;

  void updateTaskStatus(String taskId, TaskStatus newStatus) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex] = _tasks[taskIndex].copyWith(status: newStatus);
    }
  }

  Future<void> editDeadline(BuildContext context, Task task) async {
    if (task.status == TaskStatus.completed) return;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: task.deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(task.deadline),
      );

      if (pickedTime != null) {
        final newDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        final taskIndex = _tasks.indexWhere((t) => t.id == task.id);
        if (taskIndex != -1) {
          _tasks[taskIndex] = _tasks[taskIndex].copyWith(deadline: newDateTime);
        }
      }
    }
  }
}