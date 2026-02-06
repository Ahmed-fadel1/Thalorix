import 'package:flutter/material.dart';

class BuildQuickAccessCard extends StatelessWidget {
  const BuildQuickAccessCard(this.title, this.sub, this.icon, this.colors);
  final String title;
  final String sub;
  final IconData icon;
  final List<Color> colors;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 30),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(sub, style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
