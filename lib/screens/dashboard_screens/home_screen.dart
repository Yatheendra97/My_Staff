import 'package:customer_app/configurations/constants/appColors.dart';
import 'package:customer_app/configurations/constants/appTextStyles.dart';
import 'package:customer_app/configurations/constants/constants/appStrings.dart';
import 'package:customer_app/configurations/constants/constants/assetsStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/employee_cubbit.dart';
import '../../models/employee.dart';
import 'createOrUpdateEmployee_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final employeeBloc = context.read<EmployeeBloc>();
    return BlocBuilder<EmployeeBloc, List<Employee>>(
        builder: (context, employeeList) {
      return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        bottomNavigationBar: employeeList.isEmpty
            ? null
            : SafeArea(
                child: Container(
                  height: 60,
                  decoration: const BoxDecoration(
                      border: Border(
                    top: BorderSide(color: AppColors.greyColor),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.swipeLeft,
                          style: AppStyles.swipeTitleText(),
                        ),
                        SizedBox(
                          height: 45, // Set the desired height
                          width: 45,
                          child: FloatingActionButton(
                            heroTag: "add",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateOrUpdateEmployeeScreen()));
                            },
                            backgroundColor: AppColors.primaryBlueColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                    8.0), // Adjust the corner radius as needed
                              ),
                            ),
                            child: const Icon(
                              CupertinoIcons.add,
                              size: 25,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
        floatingActionButton: employeeList.isNotEmpty
            ? null
            : SizedBox(
                height: 45, // Set the desired height
                width: 45,
                child: FloatingActionButton(
                  elevation: 6,
                  heroTag: "add2",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CreateOrUpdateEmployeeScreen()));
                  },
                  backgroundColor: AppColors.primaryBlueColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                          8.0), // Adjust the corner radius as needed
                    ),
                  ),
                  child: const Icon(
                    CupertinoIcons.add,
                    size: 25,
                  ),
                ),
              ),
        appBar: AppBar(
          automaticallyImplyLeading: false, // Set this to false to remove the back arrow
          elevation: 3,
          centerTitle: false,
          backgroundColor: AppColors.primaryBlueColor,
          title: Text(AppStrings.employeeList, style: AppStyles.appBarTitleText()),
        ),
        body: employeeList.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: SvgPicture.asset(AppSvgs.empImage))
                  ],
                ),
              )
            : ListView(
          shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  _buildEmployeeList("Current Employee",
                      isCurrentEmployee: true),
                  _buildEmployeeList("Previous Employee",
                      isCurrentEmployee: false),
                ],
              ),
      );
    });
  }

  /// Custom function to build the employee list for both current and previous employees
  Widget _buildEmployeeList(String title, {required bool isCurrentEmployee}) {
    final employeeBloc = context.read<EmployeeBloc>();
    return BlocBuilder<EmployeeBloc, List<Employee>>(
      builder: (context, employeeList) {
        final filteredEmployees = employeeList.where((employee) {
          if (isCurrentEmployee) {
            return employee.leavingDate == null ||
                employee.leavingDate!.isAfter(DateTime.now());
          } else {
            return employee.leavingDate != null &&
                employee.leavingDate!.isBefore(DateTime.now());
          }
        }).toList();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(color: AppColors.greyColor),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14.0),
                    child: Text(title, style: AppStyles.listTitleText()),
                  ),
                ),
              ],
            ),
            filteredEmployees.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              AppStrings.noEmployeeList,
                              style: AppStyles.appBarTitleText(
                                  color: AppColors.primaryBlackColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 6,
                          color: AppColors.greyColor,
                        );
                      },
                      itemCount: filteredEmployees.length,
                      itemBuilder: (context, index) {
                        final employee = filteredEmployees[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CreateOrUpdateEmployeeScreen(
                                        employeeId: employee.id),
                              ),
                            );
                          },
                          child: Dismissible(
                            key: Key(employee.id.toString()),
                            onDismissed: (direction) async {
                              // Create a copy of the deleted employee for possible undo
                              final deletedEmployee = employee;

                              // Handle delete here
                              final snackBar = SnackBar(
                                content: Text(
                                  "${employee.name}'s  data has been deleted",
                                  style: AppStyles.swipeTitleText(
                                      color: AppColors.primaryWhiteColor),
                                ),
                                duration: const Duration(
                                    seconds:
                                        2), // Adjust the duration as needed
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    // Implement the undo action here, for example, by adding the deleted employee back
                                    employeeBloc.addEmployee(deletedEmployee);
                                  },
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              // Actually delete the employee
                              await employeeBloc.deleteEmployee(employee.id);
                            },
                            background: Container(
                              color: AppColors.redColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                CupertinoIcons.delete,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            secondaryBackground: Container(
                              color: AppColors.redColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                CupertinoIcons.delete,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: AppColors.scaffoldColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(employee.name,
                                            style: AppStyles.listTitleText(
                                                color: AppColors
                                                    .primaryBlackColor)),
                                        const SizedBox(height: 8),
                                        Text(employee.role,
                                            style:
                                                AppStyles.listSubTitleText()),
                                        const SizedBox(height: 8),
                                        Text(
                                            "From ${DateFormat('dd MMM yyyy').format(employee.joiningDate)}",
                                            style:
                                                AppStyles.listSubTitleText()),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }
}
