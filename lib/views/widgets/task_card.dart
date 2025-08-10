import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final String? priority;
  final Function(String, TaskStatus) onStatusChanged;
  final Function(Task) onDeadlineEdited;
  final DateTime? completedDate;

  const TaskCard({
    super.key,
    required this.task,
    this.priority,
    required this.onStatusChanged,
    required this.onDeadlineEdited,
    this.completedDate,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = task.statusColor;
    final timeStatus = task.timeStatus;

    return Opacity(
      opacity: task.status == TaskStatus.completed ? 0.55 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: statusColor,
              width: 6,
            ),
            bottom: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${task.title}-${task.id}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          task.assignedTo,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        if (task.priority != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            task.priority!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          task.status == TaskStatus.completed
                              ? 'Completed: ${DateFormat('d MMM').format(completedDate ?? DateTime.now())}'
                              : timeStatus,
                          style: TextStyle(
                            color: task.timeStatusColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (task.status != TaskStatus.completed) ...[
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => onDeadlineEdited(task),
                            child: Icon(
                              Icons.edit,
                              size: 16,
                              color: task.timeStatusColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      task.status == TaskStatus.completed
                          ? ''
                          : 'Started: ${DateFormat('d MMM').format(DateTime.now())}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (task.status != TaskStatus.completed)
                      TextButton(
                        onPressed: () {
                          if (task.status == TaskStatus.notStarted) {
                            onStatusChanged(task.id, TaskStatus.started);
                          } else {
                            onStatusChanged(task.id, TaskStatus.completed);
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              task.status == TaskStatus.notStarted
                                  ? Icons.play_arrow
                                  : Icons.check,
                              size: 16,
                              color: task.status == TaskStatus.notStarted
                                  ? Colors.blue
                                  : Colors.green,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              task.status == TaskStatus.notStarted
                                  ? 'Start Task'
                                  : 'Mark as Complete',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: task.status == TaskStatus.notStarted
                                    ? Colors.blue
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}