import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/primary_button.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class ProductCard extends StatelessWidget {
  final String imagepath;
  final String title;
 final void Function()? onpressed;
  const ProductCard({super.key,
  required this.title,
  required this.imagepath,
  required this.onpressed
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width  = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onpressed,
      child: Container(
        
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.grey.shade200,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
            aspectRatio: 1.2,
            child: Image.asset(
              imagepath,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.04,
                    ),
                  ),
                  Text("45\$",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.splashPrimary
                  )),
                  SizedBox(height: height * 0.005),
                  
                  PrimaryButton(height:height * 0.05 , text: "View template", backgroundColor: AppColors.splashPrimary, textColor: Colors.white,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}