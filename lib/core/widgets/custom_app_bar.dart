import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? action;
  final Widget? leading;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.action,
    this.leading,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leading != null ? leading : null,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF0D3B40),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actions: action != null ? [action!] : null,
      iconTheme: const IconThemeData(color: Color(0xFF0D3B40), size: 25),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
