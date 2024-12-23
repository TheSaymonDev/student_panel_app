import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarWithTitle extends StatelessWidget implements PreferredSizeWidget {
  final void Function() onPressed;
  final String title;
  final List<Widget>? actions;
  const CustomAppBarWithTitle({super.key, required this.onPressed, required this.title,  this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      leading: IconButton(
          onPressed: onPressed,
          icon: Icon(CupertinoIcons.arrow_left_circle_fill)),
      centerTitle: true,
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
