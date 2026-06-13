import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/build_otp_box.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class OtpInputWidget extends StatefulWidget {
  final int length;

  final Color activeBorderColor;

  final Color boxColor;

  final Function(String) onCodeChanged;

  final Function(String)? onCompleted;

  const OtpInputWidget({
    super.key,
    this.length = 4,
    this.activeBorderColor = AppColors.splashPrimary,
    this.boxColor = const Color.fromARGB(255, 219, 236, 243),
    required this.onCodeChanged,
    this.onCompleted,
  });

  @override
  State<OtpInputWidget> createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (index) {
        return OtpBox(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          activeBorderColor: widget.activeBorderColor,
          boxColor: widget.boxColor,

          onChanged: (value) {
            if (value.length == 1 && index < widget.length - 1) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            }
            if (value.isEmpty && index > 0) {
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }

            String currentCode = _controllers.map((c) => c.text).join();
            widget.onCodeChanged(currentCode);

            if (currentCode.length == widget.length) {
              widget.onCompleted?.call(currentCode);
            }
          },
        );
      }),
    );
  }
}
