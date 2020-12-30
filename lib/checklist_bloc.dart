import 'dart:async';

class ChecklistBloc {
  TaskList _userTaskList;

  final _taskListStreamController = StreamController<TaskList>();
  StreamSink<TaskList> get _taskListSink => _taskListStreamController.sink;
  Stream<TaskList> get taskListStream => _taskListStreamController.stream;

  final _taskController = StreamController<Task>();
  StreamSink<Task> get taskSink => _taskController.sink;
  Stream<Task> get _taskStream => _taskController.stream;

  ChecklistBloc() {
    _userTaskList = TaskList();

    _taskStream.listen(
      (task) {
        if (task != null && _userTaskList.getTaskList.contains(task)) {
          List<Task> tempTaskList = _userTaskList.getTaskList;

          tempTaskList.replaceRange(tempTaskList.indexOf(task),
              tempTaskList.indexOf(task) + 1, [task]);

          _taskListSink.add(_userTaskList);
        } else if (task != null) {
          _userTaskList.addTask(task);

          _taskListSink.add(_userTaskList);
        } else if (task == null) _taskListSink.add(_userTaskList);
      },
      onError: (err) {
        print("Error");
      },
    );
  }

  void dispose() {
    _taskListStreamController.close();

    _taskController.close();
  }
}

class Task {
  String _taskName = '';

  bool _completeStatus = false;

  DateTime _taskDeadline;

  Task(String userTaskName, DateTime userTaskDeadline,
      [bool userCompleteStatus = false]) {
    _taskName = userTaskName;

    _completeStatus = userCompleteStatus;

    _taskDeadline = userTaskDeadline;
  }

  String get getTaskName => _taskName;

  bool get getTaskCompleteStatus => _completeStatus;

  DateTime get getTaskDeadline => _taskDeadline;

  String getTaskSubtitle(DateTime userDateTime) {
    DateTime tempCurrentDate = DateTime.now();

    if (userDateTime.isBefore(tempCurrentDate))
      return "Due Today";
    else if (userDateTime.isBefore(tempCurrentDate.add(new Duration(days: 1))))
      return "Due Tomorrow";
    else
      return "Due: ${userDateTime.month}/${userDateTime.day}/${userDateTime.year}";
  }

  changeStatus() {
    _completeStatus = !_completeStatus;
  }
}

class TaskDataReturnType {
  String taskName;

  DateTime taskDeadline;

  TaskDataReturnType(this.taskName, this.taskDeadline);
}

class TaskList {
  List<Task> _tasks = [];

  List<Task> get getTaskList => _tasks;

  TaskList();

  TaskList.fromList(this._tasks);

  addTask(Task userTask) {
    _tasks.add(userTask);
  }
}
