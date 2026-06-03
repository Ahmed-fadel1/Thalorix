import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/verify_otp_usecase.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;

  OtpCubit(this.verifyOtpUseCase, this.resendOtpUseCase) : super(OtpInitial());

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

    final result = await verifyOtpUseCase(email: email, code: code, );

    result.fold(
      (failure) => emit(OtpError(failure.message)),
      (success) => emit(OtpSuccess()),
    );
  }

  Future<void> resendOtp(String email) async {
    final result = await resendOtpUseCase(email: email);

    result.fold(
      (failure) => emit(OtpError(failure.message)),
      (success) {
        resetTimer();
       
      },
    );
  }
}

