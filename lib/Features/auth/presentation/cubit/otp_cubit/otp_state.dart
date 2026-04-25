abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpCodeChanged extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {}

class OtpError extends OtpState {
  final String message;
  OtpError(this.message);
}

class OtpTimerTick extends OtpState {}

class OtpTimerFinished extends OtpState {}