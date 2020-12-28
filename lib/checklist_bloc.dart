import 'dart:async';

class ChecklistBloc {
  TaskList _userTaskList = TaskList();

  final _taskListStreamController = StreamController<TaskList>();
  StreamSink<TaskList> get taskListSink => _taskListStreamController.sink;
  Stream<TaskList> get taskListStream => _taskListStreamController.stream;

  final _taskController = StreamController<Task>();
  StreamSink<Task> get taskSink => _taskController.sink;
  Stream<Task> get taskStream => _taskController.stream;

  ChecklistBloc() {
    taskStream.listen((task) {
      _userTaskList.addTask(task);

      taskListSink.add(_userTaskList);
    });
  }

  void dispose() {
    _taskListStreamController.close();

    _taskController.close();
  }
}

class Task {
  String _taskName = '';

  Task(String userMessage) {
    _taskName = userMessage;
  }

  String get getTaskName => _taskName;
}

class TaskList {
  List<Task> _tasks = [];

  List<Task> get getTaskList => _tasks;

  addTask(Task userTask) {
    _tasks.add(userTask);
  }
}
