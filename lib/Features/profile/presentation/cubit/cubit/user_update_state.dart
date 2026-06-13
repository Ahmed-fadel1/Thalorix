import 'package:thalorix_app/Features/auth/data/models/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserUpdateSuccess extends UserState {}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class GettingUserData extends UserState {}

class UserDataLoaded extends UserState {
  final UserModel user;
  UserDataLoaded({required this.user});
}

class UserDataError extends UserState {
  final String message;
  UserDataError(this.message);
}
