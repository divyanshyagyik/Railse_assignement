import 'package:flutter/material.dart';
import '../../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function(String, TaskStatus) onStatusChanged;
  final Function(Task) onDeadlineEdited;

  const TaskCard({
    super.key,
    required this.task,
    required this.onStatusChanged,
    required this.onDeadlineEdited,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: task.statusColor,
              width: 6,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    backgroundColor: task.statusColor.withOpacity(0.2),
                    label: Text(
                      task.statusText,
                      style: TextStyle(
                        color: task.statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                task.description,
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text(
                    task.assignedTo,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: task.timeStatusColor),
                  const SizedBox(width: 4),
                  Text(
                    task.timeStatus,
                    style: TextStyle(
                      color: task.timeStatusColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: task.status != TaskStatus.completed
                        ? () => onDeadlineEdited(task)
                        : null,
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          task.formattedDate,
                          style: TextStyle(
                            color: task.status != TaskStatus.completed
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                        if (task.status == TaskStatus.notStarted)
                          const Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Icon(Icons.edit, size: 16, color: Colors.blue),
                          ),
                      ],
                    ),
                  ),
                  if (task.status == TaskStatus.notStarted)
                    ElevatedButton(
                      onPressed: () {
                        onStatusChanged(task.id, TaskStatus.started);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: const Text('Start Task'),
                    )
                  else if (task.status == TaskStatus.started)
                    ElevatedButton(
                      onPressed: () {
                        onStatusChanged(task.id, TaskStatus.completed);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: const Text('Mark Complete'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}