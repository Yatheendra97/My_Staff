import"package:flutter/material.dart";

import 'package:hive/hive.dart';

part 'employee.g.dart'; // Include the generated part file

@HiveType(typeId: 0) // Include the typeId generated by Hive
class Employee {
 @HiveField(0) // Include the field number generated by Hive
 final String id;

 @HiveField(1)
 final String name;

 @HiveField(2)
 final String role;

 @HiveField(3)
 final DateTime joiningDate;

 @HiveField(4)
 final DateTime? leavingDate;

 Employee({
  required this.id,
  required this.name,
  required this.role,
  required this.joiningDate,
  this.leavingDate,
 });

 // Create an Employee instance from a JSON map
 factory Employee.fromJson(Map<String, dynamic> json) {
  return Employee(
   id: json['id'],
   name: json['name'],
   role: json['role'],
   joiningDate: DateTime.parse(json['joiningDate']),
   leavingDate: json['leavingDate'] != null
       ? DateTime.parse(json['leavingDate'])
       : null,
  );
 }

 // Convert an Employee instance to a JSON map
 Map<String, dynamic> toJson() {
  return {
   'id': id,
   'name': name,
   'role': role,
   'joiningDate': joiningDate.toIso8601String(),
   'leavingDate': leavingDate != null ? leavingDate!.toIso8601String() : null,
  };
 }
}