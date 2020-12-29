import 'package:flutter/material.dart';
import 'package:acm_widget_mobile_app/checklist_bloc.dart';

class ChecklistPage extends StatefulWidget {
  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<ChecklistPage> {
  final checklistBloc = ChecklistBloc();

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Task"),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              MaterialButton(
                  elevation: 5.0,
                  child: Text("Add"),
                  onPressed: () {
                    Navigator.of(context).pop(customController.text.toString());
                  }),
            ],
          );
        });
  }

  @override
  void dispose() {
    checklistBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "----------Widget Built----------"); //This Prints when Widget is built.

    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: StreamBuilder(
            stream: checklistBloc.taskListStream
                .where((taskList) => taskList != null),
            builder: (context, snapshot) {
              List<Task> tempTaskList =
                  (snapshot.hasData && snapshot.data.getTaskList != null)
                      ? snapshot.data.getTaskList
                      : <Task>[];

              return (tempTaskList.length != 0)
                  ? ListView.builder(
                      itemCount: tempTaskList.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(tempTaskList[index].getTaskName),
                          value: tempTaskList[index].getTaskCompleteStatus,
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                          onChanged: (bool newValue) {
                            tempTaskList[index].changeStatus();
                            checklistBloc.taskSink.add(tempTaskList[index]);
                          },
                          secondary: MaterialButton(
                            child: Text("Delete"),
                            color: Color(0xfff7b6b2),
                            splashColor: Colors.red,
                            onPressed: () {
                              if (0 < tempTaskList.length) {
                                tempTaskList.removeAt(index);
                                checklistBloc.taskSink.add(null);
                              }
                            },
                          ),
                        );
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      child: Text(
                        "Enter Task in Checklist using the '+' Button",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.3,
                      ),
                    );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          createAlertDialog(context).then((onValue) {
            if (onValue == null)
              checklistBloc.taskSink.add(null);
            else
              checklistBloc.taskSink.add(Task(onValue.trim()));
          });
        },
      ),
    );
  }
}
