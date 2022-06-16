import 'package:flutter_todo_app/models/task_model.dart';
import 'package:hive_flutter/adapters.dart';

// benim uygulama localstorage kullanıcaksan bunları mutlaka override etmelisin diyorum.
abstract class LocalStorage {
  Future<void> addTask({required Task task});
  Future<Task?> getTask({required String id});
  Future<List<Task>> getAllTasks();
  Future<bool> deleteTask({required Task task});
  Future<Task> updateTask({required Task task});
}

// get_it paketi birbirine bağımlı olabilecek sınıfları birbirine bağlar.
class HiveLocalStorage implements LocalStorage {
  late Box<Task> _taskBox;

  HiveLocalStorage() {
    _taskBox = Hive.box<Task>('tasks');
  }

  @override
  Future<void> addTask({required Task task}) async {
    await _taskBox.put(task.id, task);
  }

  @override
  Future<bool> deleteTask({required Task task}) async {
    await task
        .delete(); // HiveObject ten türetilen taskModel sınıfım için bi güzellik var burda.
    return true;
  }

  @override
  Future<List<Task>> getAllTasks() async {
    List<Task> _allTasks = <Task>[];
    _allTasks = _taskBox.values.toList();
    if (_allTasks.isNotEmpty) {
      _allTasks.sort((Task a, Task b) => a.createdAt.compareTo(b.createdAt));
    }
    return _allTasks;
  }

  @override
  Future<Task?> getTask({required String id}) async {
    if (_taskBox.containsKey(id)) {
      return _taskBox.get(id);
    }
  }

  @override
  Future<Task> updateTask({required Task task}) async {
    await task.save();
    return task;
  }
}
