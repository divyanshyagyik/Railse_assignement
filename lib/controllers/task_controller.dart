import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskController {
  final List<Task> _tasks = [
    Task(
        id: '1',
        title: 'Auth Page',
        description: 'email authentication',
        assignedTo: 'Rakesh',
        deadline: DateTime.now().add(const Duration(hours: 2)),
        status: TaskStatus.notStarted,
        priority: 'High Priority'
    ),
    Task(
      id: '2',
      title: 'Enhance UI',
      description: 'Hero Animation',
      assignedTo: 'Anuj',
      deadline: DateTime.now().subtract(const Duration(hours: 1)),
      status: TaskStatus.started,
    ),
    Task(
      id: '3',
      title: 'Revenue',
      description: 'Google Admob',
      assignedTo: 'Ajay',
      deadline: DateTime.now().add(const Duration(days: 3)),
      status: TaskStatus.completed,
    ),
    Task(
      id: '4',
      title: 'Subscription',
      description: 'Razorpay Payment Gateway',
      assignedTo: 'Ayush',
      deadline: DateTime.now().add(const Duration(days: 5)),
      status: TaskStatus.notStarted,
    ),
    Task(
        id: '5',
        title: 'Update',
        description: 'Push Updates to github',
        assignedTo: 'Rohit',
        deadline: DateTime.now().add(const Duration(hours: 4)),
        status: TaskStatus.notStarted,
        priority: 'High Priority'
    ),
    Task(
        id: '6',
        title: 'Deploy',
        description: 'Google Play Store',
        assignedTo: 'Rohit',
        deadline: DateTime.now().add(const Duration(hours: 4)),
        status: TaskStatus.notStarted,
        priority: 'High Priority'
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