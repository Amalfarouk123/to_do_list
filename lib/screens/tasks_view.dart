import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:to_do_list/core/constant/colors.dart';

import '../core/shared/bottom_nav.dart';
import '../main.dart';

class TasksView extends StatefulWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  String? tasksData = sharedPref.getString('tasks');
  List<Map<String, dynamic>> tasksList = []; // قائمة المهام

  Future<void> loadTasks() async {
    String? tasksData = sharedPref.getString('tasks');

    if (tasksData != null) {
      setState(() {
        tasksList = List<Map<String, dynamic>>.from(jsonDecode(tasksData!));
      });
    } else {
      tasksData = null;
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
        Navigator.of(context).pushReplacementNamed('home');
        return false; // لمنع الرجوع التلقائي
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          bottomNavigationBar: BottomNav(index: 1),
          body: ListView(
            children: [
              Container(
                child: Center(
                  child: Text(
                    "المهام الحالية",
                    style: TextStyle(
                      color: AppColors.titleApp,
                      fontSize: 27,
                    ),
                  ),
                ),
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: MediaQuery.of(context).size.height - 200,
                  child: tasksList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: tasksList.length,
                          itemBuilder: (context, i) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.text,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          "إسم المهمة",
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        tasksList[i]['task'],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "لا توجد مهام حالياً",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
