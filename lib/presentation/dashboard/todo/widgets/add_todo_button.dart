import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practical/data/database/database_tables/todo_table.dart';
import 'package:practical/domain/providers/todo_provider.dart';
import 'package:practical/shared/constants/colors.dart';
import 'package:practical/shared/navigation/routes.dart';
import 'package:provider/provider.dart';

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: kPrimaryColor,
      child: const Icon(Icons.add),
      onPressed: () {
        var provider = Provider.of<TodoProvider>(context, listen: false);
        context.push(addTodoRoute).then((value) async {
          if (value != null) {
            final List<Map<String, dynamic>> storedRepos =
                await TodoTable.getData();
            var provider = Provider.of<TodoProvider>(context, listen: false);
            provider.todosList = storedRepos;
            provider.notifyListeners();
          }
        });
      },
    );
  }
}
