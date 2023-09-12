import 'package:flutter/material.dart';

class TaskModel {
  TaskModel({required this.name, required this.date, required this.time, required this.tag, required this.notes});
  final String name;
  final DateTime date;
  final TimeOfDay time;
  final String tag;
  bool completed = false;
  final String notes;
}