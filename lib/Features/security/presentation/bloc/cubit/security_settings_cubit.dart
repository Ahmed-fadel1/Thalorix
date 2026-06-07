import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thalorix_app/Features/security/domain/security_repo.dart';

part 'security_settings_state.dart';

class SecuritySettingsCubit extends Cubit<SecuritySettingsState> {
  SecuritySettingsCubit(this._repo) : super(SecurityUpdatePasswordInital());
  final SecurityRepo _repo;

  Future<void> updatePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(SecurityUpdatePasswordLoading());

    try {
      await _repo.updatePassword(
        userId: userId,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      emit(SecurityUpdatePasswordSuccess());
    } catch (e) {
      emit(SecurityUpdatePasswordError(e.toString()));
    }
  }
}
