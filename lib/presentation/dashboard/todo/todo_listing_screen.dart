import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:practical/domain/providers/todo_provider.dart';
import 'package:practical/shared/constants/colors.dart';
import 'package:practical/shared/constants/miscellaneous.dart';
import 'package:practical/shared/constants/strings.dart';
import 'package:practical/shared/navigation/routes.dart';
import 'package:practical/shared/utils/responsive_manager.dart';
import 'package:practical/shared/utils/textstyles/semi_bold_textstyles.dart';
import 'package:practical/shared/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import 'widgets/add_todo_button.dart';
import 'widgets/slidable_icons.dart';

class TodoListingScreen extends StatefulWidget {
  const TodoListingScreen({super.key});

  @override
  State<TodoListingScreen> createState() => _TodoListingScreenState();
}

class _TodoListingScreenState extends State<TodoListingScreen> {
  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    var provider = Provider.of<TodoProvider>(context, listen: false);
    provider.getStoredToDos();
  }

  BoxDecoration get decoration => BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: kLightGrey),
          color: kWhite,
          boxShadow: [
            BoxShadow(
              color: kBlack.withOpacity(0.1), // Shadow color
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: todo,
        hideSearchIcon: true,
      ),
      floatingActionButton: const AddTodoButton(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<TodoProvider>(
      builder: (BuildContext context, TodoProvider provider, Widget? child) {
        return ListView.builder(
          padding: EdgeInsets.only(top: ResponsiveManager.height(1)),
          itemCount: provider.todosList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ResponsiveManager.width(5),
                  vertical: ResponsiveManager.height(1)),
              child: Slidable(
                key: ValueKey(provider.todosList[index]["id"]),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  extentRatio: 0.4,
                  dragDismissible: true,
                  children: [
                    SlidableIcons(
                      onPressed: (context) async {
                        provider.deleteTodo(provider.todosList[index]["id"]);
                      },
                      backgroundColor: kRed,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                    ),
                    SlidableIcons(
                      onPressed: (context) {
                        context
                            .push(addTodoRoute,
                                extra: provider.todosList[index])
                            .then((value) async {
                          if (value != null) {
                            provider.appendTodo();
                          }
                        });
                      },
                      backgroundColor: kPrimaryColor,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                    ),
                  ],
                ),
                child: FadeInLeft(
                  duration: kMovieCardDuration,
                  child: Container(
                    decoration: decoration,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      provider.todosList[index]["todoName"],
                      style: text18SemiBold,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
