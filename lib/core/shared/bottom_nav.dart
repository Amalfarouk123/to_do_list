import 'package:flutter/material.dart';
import 'package:to_do_list/core/constant/colors.dart';

class BottomNav extends StatefulWidget {
  int index;
  BottomNav({required this.index});

  @override
  State<BottomNav> createState() => _BottomNavState(index: index);
}

class _BottomNavState extends State<BottomNav> {
  int index;
  _BottomNavState({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(35),
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 25,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: AppColors.icons,
        unselectedItemColor: AppColors.titleApp,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: index,
        onTap: (ind) {
          if (ind != index) {
            setState(() {
              index = ind;
            });

            if (index == 0) {
              Navigator.of(context).pushReplacementNamed("home");
            } else if (index == 1) {
              Navigator.of(context).pushReplacementNamed("tasksView");
            }
          }
        },
        items: [
          BottomNavigationBarItem(
            label: "قائمة المهام",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "المهام المتبقية",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
