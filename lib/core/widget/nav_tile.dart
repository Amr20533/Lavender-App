import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';

class NavTile extends StatelessWidget {
  const NavTile({
    super.key, required this.title, required this.icon, this.iconColor = Colors.white, required this.onTap,this.selected = false,
  });
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool selected;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        selected: selected,
        selectedTileColor: AppColors.purple200,
        leading: Icon(icon, color: iconColor,),
        trailing: Icon(Icons.arrow_forward_ios, color: title != "Logout" ? Colors.white : Colors.transparent,),
        title: AlexText(text: title,color: Colors.white, fontSize: 14,),
      ),
    );
  }
}
