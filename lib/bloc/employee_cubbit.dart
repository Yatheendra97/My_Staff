import "package:flutter_bloc/flutter_bloc.dart";
import "../models/employee.dart";
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class EmployeeBloc extends Cubit<List<Employee>> {
 EmployeeBloc() : super([]) {
  initHive();
 }

 late final Box<Employee> _employeeBox;

 Future<void> initHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  _employeeBox = await Hive.openBox<Employee>('employees');
  emit(_employeeBox.values.toList());
 }

 // Add an employee to the list and store it in Hive
 Future<void> addEmployee(Employee employee) async {
  await _employeeBox.add(employee);
  emit(_employeeBox.values.toList());
 }

 // Get all employees from Hive
 List<Employee> getAllEmployees() {
  return _employeeBox.values.toList();
 }

 // Delete an employee from the list and Hive by ID
 Future<void> deleteEmployee(String id) async {
  final index = state.indexWhere((employee) => employee.id == id);
  if (index != -1) {
   await _employeeBox.deleteAt(index);
   emit(_employeeBox.values.toList());
  }
 }

 // Edit an existing employee in the list and Hive by ID
 Future<void> editEmployee(String id, Employee updatedEmployee) async {
  final index = state.indexWhere((employee) => employee.id == id);
  if (index != -1) {
   await _employeeBox.putAt(index, updatedEmployee);
   emit(_employeeBox.values.toList());
  }
 }
}
