import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thalorix_app/Features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/auth_state.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/login_usecase.dart';
import 'package:thalorix_app/core/cache/cache_helper.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;

  AuthCubit(this.signUpUseCase, this.loginUseCase) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
Future<void> login() async {

  if (emailController.text.isEmpty ||
      passwordController.text.isEmpty) {
    emit(AuthError("Please fill all fields"));
    return;
  }

  emit(AuthLoading(AuthProcess.login));

  final result = await loginUseCase(
    email: emailController.text.trim(),
    password: passwordController.text.trim(),
  );

  result.fold(
    (failure) {
      emit(AuthError(failure.message));
    },
    (user) async {
    
      await CacheHelper.saveToken(user.accessToken);

      emit(AuthSuccess(
        process: AuthProcess.login,
        message: "Login successful",
      ));
    },
  );
}
  Future<void> signUp() async {
 
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      emit(AuthError("Please fill all fields"));
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      emit(AuthError("Passwords do not match"));
      return;
    }
    print("CUBIT STARTED");

    emit(AuthLoading(AuthProcess.signup));

    final result = await signUpUseCase(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
      role: "user",
    );
    print(" AFTER USECASE");
    result.fold(
      (failure) {
        print(" ERROR FROM USECASE: ${failure.message}"); 
        emit(AuthError(failure.message));
      },
      (user) {
        print(" SUCCESS");
        _clearControllers();
        emit(AuthSuccess(
          process: AuthProcess.signup,
          message: " Account created successfully",
        ));
      },
    );
  }

  void _clearControllers() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
