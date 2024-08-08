import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textstyle.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool autoLeading;
  final List<Widget>? iconButton;
  final String title;
  final Color? colorText;
  final IconData? icon;
  final FontWeight? fontWeigh;
  final PreferredSize? prefSize;
  const CommonAppBar({
    super.key,
    required this.autoLeading,
    this.iconButton,
    required this.title,
    this.colorText,
    this.prefSize,
    this.fontWeigh,
    this.icon,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  final Size preferredSize;
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.autoLeading,
      leading: TextButton(
          onPressed: () {
            Go.back();
          },
          child: Icon(
            widget.icon,
            color: black,
          )),
      backgroundColor: white,
      elevation: 0.5,
      centerTitle: true,
      title: CommonText(
        text: widget.title,
        color: widget.colorText,
        fontWeight: widget.fontWeigh,
      ),
      actions: widget.iconButton,
      bottom: widget.prefSize,
    );
  }
}
