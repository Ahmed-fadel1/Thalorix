part of 'security_settings_cubit.dart';

sealed class SecuritySettingsState extends Equatable {
  const SecuritySettingsState();

  @override
  List<Object> get props => [];
}

final class SecurityUpdatePasswordInital extends SecuritySettingsState {}

final class SecurityUpdatePasswordLoading extends SecuritySettingsState {}

final class SecurityUpdatePasswordSuccess extends SecuritySettingsState {}

final class SecurityUpdatePasswordError extends SecuritySettingsState {
  final String message;
  const SecurityUpdatePasswordError(this.message);
}
