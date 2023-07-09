import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/pages/task.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String? _newTask;
  Box? _box;
  _HomePageState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "TASKLY",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: _LoadTasksAndDisplay(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _LoadTasksAndDisplay() {
    return FutureBuilder(
      future: Hive.openBox("task"),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          _box = _snapshot.data;
          return _TaskList();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _TaskList() {
    List tasks = _box!.values.toList();
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext _context, int _index) {
          var task = Task.fromMap(tasks[_index]);
          return ListTile(
            title: Text(task.content,
                style: TextStyle(
                  decoration: task.done ? TextDecoration.lineThrough : null,
                )),
            subtitle: Text(
              task.timestamp.toString(),
            ),
            trailing: Icon(task.done
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank),
            onTap: () {
              setState(() {
                task.done = !task.done;
                _box!.putAt(_index, task.ToMap());
              });
            },
            onLongPress: () {
              setState(() {
                _box!.delete(_index);
              });
            },
          );
        });
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        _showTaskPopup();
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }

  void _showTaskPopup() {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          title: const Text("Add New Task !"),
          content: TextField(
            onSubmitted: (value) {
              if (_newTask != null) {
                var task = Task(
                    content: _newTask!, timestamp: DateTime.now(), done: false);
                _box?.add(task.ToMap());
                setState(() {
                  _newTask = null;
                  Navigator.pop(context);
                });
              }
            },
            onChanged: (value) {
              setState(() {
                _newTask = value;
              });
            },
          ),
        );
      },
    );
  }
}
