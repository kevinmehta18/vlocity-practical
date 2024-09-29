import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practical/data/database/database_tables/todo_table.dart';
import 'package:practical/domain/providers/todo_provider.dart';
import 'package:practical/shared/constants/colors.dart';
import 'package:practical/shared/constants/strings.dart';
import 'package:practical/shared/utils/responsive_manager.dart';
import 'package:practical/shared/utils/toasts.dart';
import 'package:practical/shared/widgets/custom_appbar.dart';
import 'package:practical/shared/widgets/custom_button.dart';
import 'package:practical/shared/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class AddTodoScreen extends StatefulWidget {
  Map<String, dynamic>? data;

  AddTodoScreen({this.data, super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.data != null) {
        _controller.text = widget.data?["todoName"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.data != null ? updateToDo : addToDo,
        hideSearchIcon: true,
        backIcon: BackButton(
          color: kBlack,
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildSaveButton(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveManager.width(5)),
      child: CustomTextField(
        controller: _controller,
        focusNode: _focusNode,
        autofocus: true,
        maxLines: 100,
        decoration: const InputDecoration(
          hintText: writeToDo,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveManager.width(5),
          vertical: ResponsiveManager.height(1)),
      child: Selector<TodoProvider, bool>(
        selector: (ctx, provider) => provider.isLoading,
        builder: (BuildContext context, isLoading, Widget? child) {
          return CustomButton(
              showLoader: isLoading,
              onPressed: _onSavePressed,
              btnText: widget.data != null ? update : save);
        },
      ),
    );
  }

  void _onSavePressed() async {
    if (_controller.text.trim().isNotEmpty) {
      var provider = Provider.of<TodoProvider>(context, listen: false);
      final todoData = {"todoName": _controller.text.trim()};
      final id = widget.data?["id"];

      id != null
          ? await provider.updateTodo(todoData, id)
          : await provider.addTodo(todoData);
      showSuccessToast();
    }
    else{
      showToast(context, emptyTodoError,toastType: ToastificationType.error);
    }
  }

  showSuccessToast() {
    showToast(context,
        widget.data != null ? todoUpdatedSuccessfully : todoAddedSuccessfully);
    Future.delayed(const Duration(seconds: 3), () {
      context.pop(true);
    });
  }
}
