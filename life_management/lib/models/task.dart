import 'package:flutter/material.dart';

class TaskModel {
  TaskModel({required this.name, required this.date, required this.time, this.tag});
  final String name;
  final DateTime date;
  final TimeOfDay time;
  String? tag;
}