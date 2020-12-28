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
                  child: Text("add"),
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
    print("----------Widget Build----------");

    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: StreamBuilder(
            stream: checklistBloc.taskListStream,
            builder: (context, snapshot) {
              return (snapshot.hasData)
                  ? ListView.builder(
                      itemCount: snapshot.data.getTaskList().length,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          activeColor: Colors.blue,
                          title: Text(
                              snapshot.data.getTaskList()[index].getTaskName()),
                        );
                      },
                    )
                  : Text("Enter Task in Checklist");
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          createAlertDialog(context).then((onValue) {
            checklistBloc.taskSink.add(Task(onValue));
          });
        },
      ),
    );
  }
}
