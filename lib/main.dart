import 'package:customer_app/screens/auth_screens/splash_screen.dart';
import 'package:customer_app/screens/dashboard_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/employee_cubbit.dart';
import 'models/employee.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await initializeHive();

  // Register Hive adapters
  registerHiveAdapters();

  // Open the Hive box
  final employeeBox = await openEmployeeBox();


  runApp(MyApp(employeeBox));
}

Future<void> initializeHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
}

void registerHiveAdapters() {
  Hive.registerAdapter(EmployeeAdapter());
}

Future<Box<Employee>> openEmployeeBox() async {
  return await Hive.openBox<Employee>('employees');
}

class MyApp extends StatelessWidget {
  final Box<Employee> employeeBox;

  MyApp(this.employeeBox);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmployeeBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'My Staff',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
