import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/local_storage_data_abs.dart';
import 'package:flutter_todo_app/main.dart';

import '../models/task_model.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  TaskItem({required this.task, Key? key}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  TextEditingController _taskNameController = TextEditingController();
  late LocalStorage _localStorage;

  @override
  void initState() {
    super.initState();
    _localStorage = locator<LocalStorage>();
    
  }

  @override
  Widget build(BuildContext context) {
    _taskNameController.text = widget.task.name;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10)
          ]),
      child: ListTile(
        title: widget.task.isCompleted
            ? Text(
                widget.task.name,
                style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.green),
              )
            : TextField(
                minLines: 1,
                maxLines: null,
                textInputAction: TextInputAction.done,
                controller: _taskNameController,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (yeniDeger) {
                  if (yeniDeger.length > 3) {
                    widget.task.name = yeniDeger;
                    _localStorage.updateTask(task: widget.task);
                  }
                },
              ),
        trailing: Text(
          DateFormat('hh:mm:a').format(widget.task.createdAt),
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        leading: GestureDetector(
          onTap: () {
            widget.task.isCompleted = !widget.task.isCompleted;
            _localStorage.updateTask(task: widget.task);
            setState(() {});
          },
          child: Container(
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                color: widget.task.isCompleted == true
                    ? Colors.green
                    : Colors.white,
                border: Border.all(color: Colors.black, width: 0.8),
                shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}
