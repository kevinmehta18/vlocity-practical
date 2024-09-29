import 'package:flutter/material.dart';
import 'package:practical/shared/constants/colors.dart';
import 'package:practical/shared/constants/strings.dart';
import 'package:practical/shared/utils/responsive_manager.dart';
import 'package:practical/shared/utils/textstyles/semi_bold_textstyles.dart';
import 'package:practical/shared/widgets/custom_textfield.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function? onSearchChanged;
  final bool? hideSearchIcon;
  final Widget? backIcon;

  const CustomAppBar({super.key, required this.title, this.onSearchChanged, this.hideSearchIcon, this.backIcon});

  @override
  CustomAppBarState createState() => CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearching = false;

  BoxDecoration get _searchDecoration => BoxDecoration(
        color: kLightGrey,
        shape: BoxShape.circle,
        border: Border.all(color: kLightGrey),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kWhite,
      automaticallyImplyLeading: false,
      leading: widget.backIcon,
      elevation: 0,
      centerTitle: true,
      title: _isSearching
          ? CustomTextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              autofocus: true,
              hintText: search,
              labelText: search,
              onChanged: (value) {
                if (widget.onSearchChanged != null) {
                  widget.onSearchChanged!(value);
                }
              },
            )
          : Text(
              widget.title,
              style: text24SemiBold.copyWith(color: kBlack),
            ),
      actions: [
        Visibility(visible: widget.hideSearchIcon!=true, child: _buildActionIcon()),
      ],
    );
  }

  Widget _buildActionIcon() {
    return Container(
      margin: EdgeInsets.only(right: ResponsiveManager.width(5)),
      padding: const EdgeInsets.all(8),
      decoration: _searchDecoration,
      child: GestureDetector(
        onTap: _onSearch,
        child: _buildSearchIcon(),
      ),
    );
  }

  Widget _buildSearchIcon() {
    return Icon(
      _isSearching ? Icons.clear : Icons.search,
      color: kBlack,
      size: 20,
    );
  }

  void _onSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        widget.onSearchChanged;
      }
    });
  }
}
