enum AuthProcess { signup, login, verifyOtp, forgotPassword, resetPassword }

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  final AuthProcess process;

  AuthLoading(this.process);
}

class AuthSuccess extends AuthState {
  final AuthProcess process;
  final String? message;

  AuthSuccess({required this.process, this.message});
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
