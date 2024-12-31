import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:to_do_list/core/shared/bottom_nav.dart';
import 'package:to_do_list/core/constant/colors.dart';

import '../core/func/showConfirmDialog.dart';
import '../core/shared/CustomTextFiled.dart';
import '../core/shared/customElevatedButton.dart';
import '../main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController taskController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  List<Map<String, dynamic>> tasksList = []; // قائمة المهام

  Future<void> saveTasks() async {
    await sharedPref.setString('tasks', jsonEncode(tasksList));
  }

  Future<void> loadTasks() async {
    String? tasksData = sharedPref.getString('tasks');

    if (tasksData != null) {
      setState(() {
        tasksList = List<Map<String, dynamic>>.from(jsonDecode(tasksData));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true; // للسماح بالخروج من التطبيق عند الرجوع من الصفحة الرئيسية
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          bottomNavigationBar: BottomNav(index: 0),
          body: Form(
            key: formState,
            child: ListView(
              children: [
                Container(
                  child: Center(
                    child: Text(
                      "قائمة المهام",
                      style: TextStyle(
                        color: AppColors.titleApp,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomTextFiled(taskController: taskController),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomGeneralButton(
                    onPressed: () {
                      if (formState.currentState!.validate()) {
                        setState(() {
                          tasksList.add({
                            "task": taskController.text,
                            "isChecked": false
                          });
                          taskController.clear();
                          saveTasks();
                        });
                      }
                    },
                    name: ' إضافة المهمة',
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 320,
                    child: ListView.builder(
                      itemCount: tasksList.length,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CheckboxListTile(
                            value: tasksList[i]['isChecked'],
                            onChanged: (val) {
                              setState(() {
                                tasksList[i]['isChecked'] = val!;
                                saveTasks();
                              });
                            },
                            title: Text(
                              tasksList[i]['task'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: tasksList[i]['isChecked']
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "تم إكمال المهمة",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.gray),
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    "مهمة ليست مكتملة",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromRGBO(158, 158, 158, 1)),
                                  ),
                            secondary: tasksList[i]['isChecked']
                                ? IconButton(
                                    onPressed: () {
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CupertinoAlertDialog(
                                          title: Text('حذف'),
                                          content: Text(
                                              'هل أنت متأكد من حذف هذه المهمة ؟'),
                                          actions: <Widget>[
                                            CupertinoDialogAction(
                                              child: Text(
                                                'خروج',
                                                style: TextStyle(
                                                    color: AppColors.primary),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              child: Text('حذف'),
                                              onPressed: () {
                                                setState(() {
                                                  tasksList.removeAt(i);
                                                  saveTasks();

                                                  Navigator.of(context).pop();
                                                  setState(() {});
                                                  showConfirmDialog(
                                                      context,
                                                      "رسالة",
                                                      "تم حذف المهمة بنجاح");
                                                });
                                              },
                                              isDestructiveAction: true,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.delete),
                                    color: AppColors.error,
                                  )
                                : Icon(
                                    Icons.check_circle_outline,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                            activeColor: Theme.of(context).iconTheme.color,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
