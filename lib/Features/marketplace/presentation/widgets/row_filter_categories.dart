import 'package:flutter/material.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:toggle_switch/toggle_switch.dart';

class RowFilterCategories extends StatelessWidget {
  const RowFilterCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
       
        children: [
          Icon(Icons.filter_list_rounded),
          Text("Filters", style: TextStyle(fontWeight: FontWeight.bold)),
          Spacer(),
          ToggleSwitch(
            totalSwitches: 3,
            labels: ["All", "Web Design", "Mobile"],
         
            initialLabelIndex: 0,
            customWidths: [60, 120, 90],
            cornerRadius: 15,
            dividerColor: Colors.transparent,
            borderWidth: 0,
            dividerMargin: 8.0,
      
            inactiveBgColor: Colors.transparent,
            activeBgColor: [Color(0xFFB2D8D8)],
            
            activeFgColor: AppColors.iconbutton,
            inactiveFgColor: AppColors.iconbutton,
          ),
        ],
      ),
    );
  }
}
