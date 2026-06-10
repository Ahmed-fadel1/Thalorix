import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/profile/domain/repo/user_repo.dart';
import 'package:thalorix_app/Features/profile/presentation/cubit/cubit/user_update_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _repo;
  UserCubit(this._repo) : super(UserInitial());

  Future<void> updateUser({
    required String userId,
    String? name,
    String? email,
    String? phone,
    String? bio,
  }) async {
    emit(UserLoading());
    try {
      await _repo.updateUser(
        userId: userId,
        name: name,
        email: email,
        phone: phone,
        bio: bio,
      );
      emit(UserUpdateSuccess());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> getUserData(String userId) async {
    emit(GettingUserData());
    try {
      final userData = await _repo.getUserData(userId: userId);

      if (userData != null) {
        emit(UserDataLoaded(user: userData));
      } else {
        emit(UserDataError("لم يتم العثور على بيانات المستخدم"));
      }
    } catch (e) {
      emit(UserDataError("حدث خطأ أثناء تحميل البيانات"));
    }
  }
}
