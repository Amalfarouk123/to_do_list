import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({
    super.key,
    required this.taskController,
  });

  final TextEditingController taskController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: taskController,
      validator: (value) {
        if (value!.isEmpty) {
          return "الحقل لا يجب أن يكون فارغ";
        } else if (value.length < 3) {
          return "عدد الحروف يجب أن يكون أكبر من حرفان";
        } else if (value.length > 200) {
          return "عدد الحروف يجب أن يكون أصغر من 200 حرف";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 7),
        hintText: "أدخل المهمة",
        labelText: "أدخل المهمة",
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          Icons.add_task_sharp,
          color: Theme.of(context).iconTheme.color,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
