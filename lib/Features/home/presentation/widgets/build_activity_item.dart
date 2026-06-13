import 'package:flutter/material.dart';

class BuildActivityItem extends StatelessWidget {
  const BuildActivityItem(this.title, this.time, this.status, this.icon);
  final String title;
  final String time;
  final String status;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xffE5E7EB),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Color(0xFF0D3B40)),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(time, style: TextStyle(fontSize: 12)),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Color(0xFFE0F2F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                status,
                style: TextStyle(fontSize: 10, color: Color(0xFF3B6B6B)),
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 14),
      ),
    );
  }
}
