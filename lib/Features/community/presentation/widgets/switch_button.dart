//   import 'package:flutter/material.dart';

// class SwitchButton extends StatelessWidget {
//    final String text;
//   final int index;
//   final int selectedIndex;
//   final VoidCallback onTap;
//   const SwitchButton({super.key,
//   required this.text,
//   required this.index,
//   required this.selectedIndex,
//   required this.onTap
  
//   });


//   @override
//   Widget build(BuildContext context) {
   
  
//        final bool isSelected = selectedIndex == index;


//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 45,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: isSelected
//               ? const Color(0xFF0D3B40)
//               : Colors.transparent,
//           borderRadius: BorderRadius.only(
//             topLeft: index == 0
//                 ? const Radius.circular(18)
//                 : Radius.zero,
//             bottomLeft: index == 0
//                 ? const Radius.circular(18)
//                 : Radius.zero,
//             topRight: index == 1
//                 ? const Radius.circular(18)
//                 : Radius.zero,
//             bottomRight: index == 1
//                 ? const Radius.circular(18)
//                 : Radius.zero,
//           ),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color:
//                 isSelected ? Colors.white : const Color(0xFF0D3B40),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class SwitchButton extends StatelessWidget {
  final String text;
  final int index;
  final int selectedIndex;
  final VoidCallback onTap;

  const SwitchButton({
    super.key,
    required this.text,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;
    final bool isFirst = index == 0;
    final bool isLast = index == 1;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0D3B40)
              : Colors.white,
          border: Border.all(
            color: const Color(0xFF0D3B40),
            width: 1.2,
          ),
          borderRadius: BorderRadius.only(
            topLeft: isFirst ? const Radius.circular(18) : Radius.zero,
            bottomLeft: isFirst ? const Radius.circular(18) : Radius.zero,
            topRight: isLast ? const Radius.circular(18) : Radius.zero,
            bottomRight: isLast ? const Radius.circular(18) : Radius.zero,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF0D3B40),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}