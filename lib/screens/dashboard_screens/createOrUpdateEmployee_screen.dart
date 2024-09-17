import 'package:customer_app/configurations/constants/appColors.dart';
import 'package:customer_app/configurations/constants/appTextStyles.dart';
import 'package:customer_app/configurations/constants/constants/appStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:some_calendar/some_calendar.dart';
import '../../bloc/employee_cubbit.dart';
import '../../models/employee.dart';
import 'package:uuid/uuid.dart';

class CreateOrUpdateEmployeeScreen extends StatefulWidget {
  final String? employeeId; // Define the employeeId as a parameter

  const CreateOrUpdateEmployeeScreen({Key? key, this.employeeId}) : super(key: key);

  @override
  State<CreateOrUpdateEmployeeScreen> createState() => _CreateOrUpdateEmployeeScreenState();
}

class _CreateOrUpdateEmployeeScreenState extends State<CreateOrUpdateEmployeeScreen> {
  TextEditingController employeeNameController = TextEditingController();
  DateTime? joiningDate;
  DateTime? leavingDate;
  String? selectedRole; // Initialize with the default value

/// Save Employee
  Future<void> saveEmployee(EmployeeBloc employeeBloc) async {
    final newEmployee = Employee(
      id: const Uuid().v1(), // You can use any unique ID generation method
      name: employeeNameController.text,
      role: selectedRole!,
      joiningDate: joiningDate!,
      leavingDate: leavingDate,
    );

    await employeeBloc.addEmployee(newEmployee);

    Navigator.pop(context); // Navigate back to the previous screen
  }

/// Update Employee
  Future<void> updateEmployee(EmployeeBloc employeeBloc) async {
    if (widget.employeeId == null) return;
    final updatedEmployee = Employee(
      id: widget.employeeId ?? "", // Use the existing employee's ID
      name: employeeNameController.text,
      role: selectedRole!,
      joiningDate: joiningDate!,
      leavingDate: leavingDate,
    );

    await employeeBloc.editEmployee(widget.employeeId ?? "", updatedEmployee);

    Navigator.pop(context); // Navigate back to the previous screen
  }
/// Roles Upadate
  void updateRole(String newRole) {
    setState(() {
      selectedRole = newRole;
    });
  }
/// Date Format
  String? formatDate(DateTime? dateTime) {
    if (dateTime == null) return null;
    final DateFormat format = DateFormat("d MMM y");
    return format.format(dateTime);
  }

/// Joining Date Calender
  Future<void> _selectJoiningDate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    String selectedDay = "";
    DateTime? selectedDate = joiningDate ?? DateTime.now();
    DateTime getDate(String input) {
      final currentDate = DateTime.now();

      if (input == "Nxt_MON") {
        int daysUntilNextMonday = DateTime.monday - currentDate.weekday;
        if (daysUntilNextMonday <= 0) {
          daysUntilNextMonday += 7; // Move to next week
        }
        return currentDate.add(Duration(days: daysUntilNextMonday));
      } else if (input == "Nxt_TUES") {
        int daysUntilNextTuesday = DateTime.tuesday - currentDate.weekday;
        if (daysUntilNextTuesday <= 0) {
          daysUntilNextTuesday += 7; // Move to next week
        }
        return currentDate.add(Duration(days: daysUntilNextTuesday));
      } else if (input == "Nxt_WEEK") {
        int daysUntilNextMonday = DateTime.monday - currentDate.weekday;
        if (daysUntilNextMonday <= 0) {
          daysUntilNextMonday += 7; // Move to next week
        }
        return currentDate.add(Duration(days: daysUntilNextMonday + 7)); // Start of the week after the next Monday
      } else if (input == "Today") {
        return currentDate;
      }

      // Return the current date as a default
      return currentDate;
    }

    showDialog(
        context: context,
        builder: (_) => Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: StatefulBuilder(builder: (context, changeState) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                changeState(() {
                                  selectedDay = "Today";
                                  selectedDate = getDate(selectedDay);
                                });
                              },
                              child: Container(
                                height: 35,
                                width: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: selectedDay == "Today" ? AppColors.primaryBlueColor : AppColors.lightBlueColor, borderRadius: BorderRadius.circular(6.0)),
                                child: Text(
                                  "Today",
                                  style: AppStyles.buttonTitleText(color: selectedDay == "Today" ? AppColors.primaryWhiteColor : AppColors.primaryBlueColor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                changeState(() {
                                  selectedDay = "Nxt_MON";
                                  selectedDate = getDate(selectedDay);
                                });
                              },
                              child: Container(
                                height: 35,
                                width: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: selectedDay == "Nxt_MON" ? AppColors.primaryBlueColor : AppColors.lightBlueColor, borderRadius: BorderRadius.circular(6.0)),
                                child: Text(
                                  "Next Monday",
                                  style: AppStyles.buttonTitleText(color: selectedDay == "Nxt_MON" ? AppColors.primaryWhiteColor : AppColors.primaryBlueColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                changeState(() {
                                  selectedDay = "Nxt_TUES";
                                  selectedDate = getDate(selectedDay);
                                });
                              },
                              child: Container(
                                height: 35,
                                width: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: selectedDay == "Nxt_TUES" ? AppColors.primaryBlueColor : AppColors.lightBlueColor, borderRadius: BorderRadius.circular(6.0)),
                                child: Text(
                                  "Next TuesDay",
                                  style: AppStyles.buttonTitleText(color: selectedDay == "Nxt_TUES" ? AppColors.primaryWhiteColor : AppColors.primaryBlueColor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                changeState(() {
                                  selectedDay = "Nxt_WEEK";
                                  selectedDate = getDate(selectedDay);
                                });
                              },
                              child: Container(
                                height: 35,
                                width: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: selectedDay == "Nxt_WEEK" ? AppColors.primaryBlueColor : AppColors.lightBlueColor, borderRadius: BorderRadius.circular(6.0)),
                                child: Text(
                                  "After 1 week",
                                  style: AppStyles.buttonTitleText(color: selectedDay == "Nxt_WEEK" ? AppColors.primaryWhiteColor : AppColors.primaryBlueColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Flexible(
                        child: SomeCalendar(
                          mode: SomeMode.Single,
                          isWithoutDialog: true,
                          primaryColor: AppColors.primaryBlueColor,
                          scrollDirection: Axis.horizontal,
                          selectedDate: selectedDate ?? DateTime.now(),
                          startDate: DateTime(2000),
                          lastDate: DateTime.now().add(const Duration(days: 60)),
                          done: (date) {
                            if (date != null) {
                              changeState(() {
                                selectedDay = "";
                                selectedDate = date;
                              });
                            }
                          },
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 35,
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              // decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0), border: Border.all(color: AppColors.greyColor)),
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.event_outlined,
                                        size: 22,
                                        color: AppColors.primaryBlueColor,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(formatDate(selectedDate) ?? "No Date", style: AppStyles.textFieldTitleText(color: AppColors.primaryBlackColor)),
                                ],
                              ),
                            ),
                          ),
                          // const SizedBox(width: 10,),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 35,
                              width: 55,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: AppColors.lightBlueColor, borderRadius: BorderRadius.circular(6.0)),
                              child: Text(
                                AppStrings.cancel,
                                style: AppStyles.buttonTitleText(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                joiningDate = selectedDate;
                                if (leavingDate != null && leavingDate!.isBefore(joiningDate!)) {
                                    leavingDate = null;
                                }
                              });

                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 35,
                              width: 55,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: AppColors.primaryBlueColor, borderRadius: BorderRadius.circular(6.0)),
                              child: Text(
                                AppStrings.save,
                                style: AppStyles.buttonTitleText(color: AppColors.primaryWhiteColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                );
              }),
            ));
  }
/// Leaving Date Calender
  Future<void> _selectLeavingDate(BuildContext context) async {
    String selectedDay = "";
    FocusScope.of(context).unfocus();
    DateTime? selectedDate = leavingDate ?? DateTime.now();

    DateTime getDate(String input) {
      final currentDate = DateTime.now();
      if (input == "Today") {
        return currentDate;
      }
      // Return the current date as a default
      return currentDate;
    }

    showDialog(
        context: context,
        builder: (_) => Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: StatefulBuilder(builder: (context, changeState) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                changeState(() {
                                  selectedDay = "No_Date";
                                  selectedDate = null;
                                });
                              },
                              child: Container(
                                height: 35,
                                width: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: selectedDay == "No_Date" ? AppColors.primaryBlueColor : AppColors.lightBlueColor, borderRadius: BorderRadius.circular(6.0)),
                                child: Text(
                                  "No Date",
                                  style: AppStyles.buttonTitleText(color: selectedDay == "No_Date" ? AppColors.primaryWhiteColor : AppColors.primaryBlueColor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                changeState(() {
                                  selectedDay = "Today";
                                  selectedDate = getDate(selectedDay);
                                });
                              },
                              child: Container(
                                height: 35,
                                width: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: selectedDay == "Today" ? AppColors.primaryBlueColor : AppColors.lightBlueColor, borderRadius: BorderRadius.circular(6.0)),
                                child: Text(
                                  "Today",
                                  style: AppStyles.buttonTitleText(color: selectedDay == "Today" ? AppColors.primaryWhiteColor : AppColors.primaryBlueColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Flexible(
                        child: SomeCalendar(
                          mode: SomeMode.Single,
                          isWithoutDialog: true,
                          primaryColor: AppColors.primaryBlueColor,
                          scrollDirection: Axis.horizontal,
                          selectedDate: selectedDate ?? DateTime.now(),
                          startDate: joiningDate ?? DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 60)),
                          done: (date) {
                            if (date != null) {
                              changeState(() {
                                selectedDay = "";
                                selectedDate = date;
                              });
                            }
                          },
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 35,
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              // decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0), border: Border.all(color: AppColors.greyColor)),
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.event_outlined,
                                        size: 22,
                                        color: AppColors.primaryBlueColor,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(formatDate(selectedDate) ?? "No Date", style: AppStyles.textFieldTitleText(color: AppColors.primaryBlackColor)),
                                ],
                              ),
                            ),
                          ),
                          // const SizedBox(width: 10,),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 35,
                              width: 55,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: AppColors.lightBlueColor, borderRadius: BorderRadius.circular(6.0)),
                              child: Text(
                                AppStrings.cancel,
                                style: AppStyles.buttonTitleText(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                leavingDate = selectedDate;
                              });

                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 35,
                              width: 55,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: AppColors.primaryBlueColor, borderRadius: BorderRadius.circular(6.0)),
                              child: Text(
                                AppStrings.save,
                                style: AppStyles.buttonTitleText(color: AppColors.primaryWhiteColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                );
              }),
            ));
  }

  Employee? getEmployeeById(
    String id,
  ) {
    // Retrieve the employee by ID from the EmployeeBloc state
    final employee = context
        .read<EmployeeBloc>()
        .state
        .where(
          (employee) => employee.id == id,
        )
        .firstOrNull;
    return employee;
  }

  @override
  void initState() {
    // Prefill fields if employeeId is provided
    if (widget.employeeId != null) {
      // Retrieve employee data by employeeId
      final employee = getEmployeeById(widget.employeeId!); // Implement getEmployeeById
      if (employee != null) {
        // Prefill fields with employee data
        employeeNameController.text = employee.name;
        selectedRole = employee.role;
        joiningDate = employee.joiningDate;
        if (employee.leavingDate != null) {
          leavingDate = employee.leavingDate;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove the back arrow
          backgroundColor: AppColors.primaryBlueColor,
          centerTitle: false,
          title: Text(widget.employeeId!=null?AppStrings.editEmployee:AppStrings.addEmployee, textAlign: TextAlign.start,style: AppStyles.appBarTitleText()),
     actions:widget.employeeId!=null? [
       IconButton(onPressed: (){

         context.read<EmployeeBloc>().deleteEmployee(widget.employeeId!);
         Navigator.pop(context);
       }, icon: Icon(CupertinoIcons.delete,size: 25,)),
     ]:null,
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          child: Column(
            children: [
/// Employee Name
              Container(
                height: 40,
                alignment: Alignment.center,
                child: TextFormField(
                    controller: employeeNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      hintText: AppStrings.employeeName,
                      hintStyle: AppStyles.textFieldTitleText(),
                      prefixIcon: const Icon(
                        CupertinoIcons.person,
                        size: 24,
                        color: AppColors.primaryBlueColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: const BorderSide(
                          color: AppColors.greyColor, // Update the border color based on focus state
                          width: 1.0,
                        ),
                      ),
                    ),
                    style: AppStyles.subTitleStyle()),
              ),
              const SizedBox(height: 20,),

/// Select Role
              InkWell(
                onTap: () {
                  _showBottomSheet(context);
                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0), border: Border.all(color: AppColors.greyColor)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.work_outline,
                        size: 24,
                        color: AppColors.primaryBlueColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(selectedRole ?? "Select Role", style: AppStyles.textFieldTitleText(color: selectedRole==null?AppColors.greyShade:AppColors.primaryBlackColor)),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: AppColors.primaryBlueColor,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
/// Joining & Leaving Dates
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _selectJoiningDate(context);
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0), border: Border.all(color: AppColors.greyColor)),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.event_outlined,
                                  size: 24,
                                  color: AppColors.primaryBlueColor,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(formatDate(joiningDate) ?? "Today", style: AppStyles.textFieldTitleText(color: joiningDate==null?AppColors.greyShade:AppColors.primaryBlackColor)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Transform.rotate(
                      angle: 3.15,
                      child: const Icon(
                        Icons.keyboard_backspace,
                        size: 20,
                        color: AppColors.primaryBlueColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _selectLeavingDate(context);
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0), border: Border.all(color: AppColors.greyColor)),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.event_outlined,
                                  size: 24,
                                  color: AppColors.primaryBlueColor,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(formatDate(leavingDate) ?? "No Date", style: AppStyles.textFieldTitleText(color: leavingDate==null?AppColors.greyShade:AppColors.primaryBlackColor)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Divider(height: 0,),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 35,
                        width: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: AppColors.lightBlueColor, borderRadius: BorderRadius.circular(6.0)),
                        child: Text(
                          AppStrings.cancel,
                          style: AppStyles.buttonTitleText(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (widget.employeeId == null) {
                          if (joiningDate != null && selectedRole != null && employeeNameController.text.isNotEmpty) {
                            // New Employee
                            saveEmployee(context.read<EmployeeBloc>());
                          } else {
                            List<String> errors = [];

                            if (joiningDate == null) {
                              errors.add('joining date');
                            }

                            if (selectedRole == null) {
                              errors.add('role');
                            }

                            if (employeeNameController.text.isEmpty) {
                              errors.add('employee name');
                            }

                            String message;

                            if (errors.isEmpty) {
                              message = 'All fields are missing.';
                            } else {
                              message = 'Missing ${errors.join(', ')} field${errors.length > 1 ? 's' : ''}.';
                            }

                            final snackBar = SnackBar(
                              content: Text(message),
                              duration: const Duration(seconds: 2), // Adjust the duration as needed
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        } else {
                          updateEmployee(context.read<EmployeeBloc>());
                        }
                      },
                      child: Container(
                        height: 35,
                        width: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: AppColors.primaryBlueColor, borderRadius: BorderRadius.circular(6.0)),
                        child: Text(
                          AppStrings.save,
                          style: AppStyles.buttonTitleText(color: AppColors.primaryWhiteColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Bottom Sheet For Roles
  void _showBottomSheet(BuildContext context) {
    FocusScope.of(context).unfocus();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    updateRole(AppStrings.prodDesigner);
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(
                    AppStrings.prodDesigner,
                    style: AppStyles.subTitleStyle(),
                  ))),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                color: AppColors.greyColor,
              ),
              const SizedBox(
                height: 2,
              ),
              InkWell(
                  onTap: () {
                    updateRole(AppStrings.flutterDev);
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(
                    AppStrings.flutterDev,
                    style: AppStyles.subTitleStyle(),
                  ))),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                color: AppColors.greyColor,
              ),
              const SizedBox(
                height: 2,
              ),
              InkWell(
                  onTap: () {
                    updateRole(AppStrings.qATester);
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(
                    AppStrings.qATester,
                    style: AppStyles.subTitleStyle(),
                  ))),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                color: AppColors.greyColor,
              ),
              const SizedBox(
                height: 2,
              ),
              InkWell(
                  onTap: () {
                    updateRole(AppStrings.prodOwner);
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(
                    AppStrings.prodOwner,
                    style: AppStyles.subTitleStyle(),
                  ))),
              const SizedBox(
                height: 4,
              )
            ],
          ),
        );
      },
    );
  }
}
