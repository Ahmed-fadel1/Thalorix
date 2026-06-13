import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/auth/data/models/user_model.dart';
import 'package:thalorix_app/Features/profile/domain/repo/user_repo.dart';
import 'package:thalorix_app/Features/profile/presentation/cubit/cubit/user_update_state.dart';
import 'package:thalorix_app/core/cache/cache_helper.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _repo;
  UserModel? currentUser;

  UserCubit(this._repo) : super(UserInitial());

  Future<void> updateUser({
    required String userId,
    String? name,
    String? email,
    String? phone,
    String? bio,
    String? profilePic,
  }) async {
    emit(UserLoading());
    try {
      await _repo.updateUser(
        userId: userId,
        name: name,
        email: email,
        phone: phone,
        bio: bio,
        profilePic: profilePic,
      );
      
      if (currentUser != null) {
        currentUser = UserModel(
          id: currentUser!.id,
          name: name ?? currentUser!.name,
          email: email ?? currentUser!.email,
          role: currentUser!.role,
          isVerified: currentUser!.isVerified,
          phone: phone ?? currentUser!.phone,
          bio: bio ?? currentUser!.bio,
          profilePic: profilePic ?? currentUser!.profilePic,
        );
      }
      
      if (profilePic != null) await CacheHelper.saveProfilePic(profilePic);
      if (name != null) await CacheHelper.saveName(name);

      emit(UserUpdateSuccess());
      if (currentUser != null) emit(UserDataLoaded(user: currentUser!));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> uploadProfilePic({
    required String imagePath,
    required String slug,
    required String userId,
  }) async {
    emit(UserLoading());
    try {
      final imageUrl = await _repo.uploadProfileImage(imagePath: imagePath, slug: slug);
      await _repo.updateUser(userId: userId, profilePic: imageUrl);
      
      if (currentUser != null) {
        currentUser = UserModel(
          id: currentUser!.id,
          name: currentUser!.name,
          email: currentUser!.email,
          role: currentUser!.role,
          isVerified: currentUser!.isVerified,
          phone: currentUser!.phone,
          bio: currentUser!.bio,
          profilePic: imageUrl,
        );
      }
      
      await CacheHelper.saveProfilePic(imageUrl);

      emit(UserUpdateSuccess());
      if (currentUser != null) emit(UserDataLoaded(user: currentUser!));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> getUserData(String userId) async {
    emit(GettingUserData());
    try {
      final userData = await _repo.getUserData(userId: userId);

      if (userData != null) {
        // Fallback to cache if backend still doesn't return it
        final cachedPic = CacheHelper.getProfilePic();
        if (userData.profilePic == null && cachedPic != null) {
          currentUser = UserModel(
            id: userData.id,
            name: userData.name,
            email: userData.email,
            role: userData.role,
            isVerified: userData.isVerified,
            phone: userData.phone,
            bio: userData.bio,
            profilePic: cachedPic,
          );
        } else {
          currentUser = userData;
          if (userData.profilePic != null) {
            await CacheHelper.saveProfilePic(userData.profilePic!);
          }
        }
        emit(UserDataLoaded(user: currentUser!));
      } else {
        emit(UserDataError("لم يتم العثور على بيانات المستخدم"));
      }
    } catch (e) {
      emit(UserDataError("حدث خطأ أثناء تحميل البيانات"));
    }
  }
}
