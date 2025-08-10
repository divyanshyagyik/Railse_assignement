import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TaskStatus { notStarted, started, completed }

class Task {
  final String id;
  final String title;
  final String description;
  final String assignedTo;
  final DateTime deadline;
  final TaskStatus status;
  final String? priority;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.deadline,
    required this.status,
    this.priority,
  });


  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? assignedTo,
    DateTime? deadline,
    TaskStatus? status,
    String? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      assignedTo: assignedTo ?? this.assignedTo,
      deadline: deadline ?? this.deadline,
      status: status ?? this.status,
      priority: priority ?? this.priority,
    );
  }

  String get formattedDate {
    return DateFormat('MMM dd, yyyy - hh:mm a').format(deadline);
  }

  String get statusText {
    switch (status) {
      case TaskStatus.notStarted:
        return 'Not Started';
      case TaskStatus.started:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
    }
  }

  Color get statusColor {
    switch (status) {
      case TaskStatus.notStarted:
        return Colors.grey;
      case TaskStatus.started:
        return Colors.blue;
      case TaskStatus.completed:
        return Colors.green;
    }
  }

  Color get overdueColor => Colors.red;
  Color get dueColor => Colors.orange;
  Color get completedColor => Colors.green;


  String get timeStatus {
    if (status == TaskStatus.completed) {
      return 'Completed';
    }

    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.isNegative) {
      return 'Overdue by ${DateFormat('hh:mm a').format(deadline)}';
    } else if (difference.inHours < 24){
      return 'Due in ${difference.inHours}h ${difference.inMinutes.remainder(60)}m';
    }
    else {
      return 'Due in ${difference.inDays}d';
    }
  }

  Color get timeStatusColor {
    if (status == TaskStatus.completed) {
      return Colors.green;
    }

    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.isNegative) {
      return Colors.red;
    } else if(difference.inHours < 24) {
      return Colors.orange;
    } else {
      return Colors.orange;
    }
  }
}