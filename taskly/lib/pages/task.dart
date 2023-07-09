import 'package:flutter/material.dart';

class Task {
  late String content;
  late DateTime timestamp;
  late bool done;
  Task({required this.content, required this.timestamp, required this.done});
  Map ToMap() {
    return {
      "content": content,
      "timestamp": timestamp,
      "done": done,
    };
  }

  factory Task.fromMap(Map task) {
    return Task(
        content: task["content"],
        timestamp: task["timestamp"],
        done: task["done"]);
  }
}
