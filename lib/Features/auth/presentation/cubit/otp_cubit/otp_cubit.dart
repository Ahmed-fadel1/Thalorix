import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import 'package:thalorix_app/core/network/dio_helper.dart';
import 'package:thalorix_app/core/network/end_point.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  static OtpCubit get(context) => BlocProvider.of(context);

  String otpCode = "";
  int seconds = 120;
  Timer? timer;

  void setOtp(String code) {
    otpCode = code;
    emit(OtpCodeChanged());
  }

  bool get isOtpComplete => otpCode.length == 6;

  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
        emit(OtpTimerFinished());
      } else {
        seconds--;
        emit(OtpTimerTick());
      }
    });
  }

  void resetTimer() {
    seconds = 120;
    startTimer();
  }

  String get formattedTime {
    int mins = seconds ~/ 60;
    int secs = seconds % 60;
    return "${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  Future<void> verifyOtp({required String email, required String code}) async {
    emit(OtpLoading());

    try {
      final response = await DioHelper.postData(
        url: ApiEndpoints.verifyOtp,
        data: {"email": email, "code": code},
      );

      print("VERIFY RESPONSE: ${response.data}");

      emit(OtpSuccess());
    } catch (e) {
      if (e is Failure) {
        emit(OtpError(e.message));
      } else {
        emit(OtpError("Something went wrong"));
      }
    }
  }

  Future<void> resendOtp(String email) async {
    print("RESENDING OTP TO: $email"); 
    try {
      final response = await DioHelper.postData(
        url: ApiEndpoints.resendOtp,
        data: {
          "email": email,
          "type": "email_verification",
        },
      );

      print("RESEND RESPONSE: ${response.data}");
      resetTimer();
    } catch (e) {
      print("RESEND ERROR: $e");
      if (e is Failure) {
        emit(OtpError(e.message));
      } else {
        emit(OtpError("Failed to resend OTP"));
      }
    }
  }
}
