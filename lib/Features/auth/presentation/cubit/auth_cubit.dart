import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/auth/data/models/user_model.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/auth_state.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/login_usecase.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:thalorix_app/core/cache/cache_helper.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  String? lastEmail;

  AuthCubit(
    this.signUpUseCase,
    this.loginUseCase,
    this.forgotPasswordUseCase,
    this.resetPasswordUseCase,
  ) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
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
      (loginResponse) async {
        await CacheHelper.saveUserId(loginResponse.user.id);
        await CacheHelper.saveToken(loginResponse.accessToken);
        await CacheHelper.saveName(loginResponse.user.name);

        emit(
          AuthSuccess(process: AuthProcess.login, message: "Login successful"),
        );
      },
    );
  }

  Future<void> signUp({required String email}) async {
    lastEmail = email;
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
      email: email,
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
        emit(
          AuthSuccess(
            process: AuthProcess.signup,
            message: " Account created successfully",
          ),
        );
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

  Future<void> forgotPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      emit(AuthError("Please enter your email"));
      return;
    }

    emit(AuthLoading(AuthProcess.forgotPassword));

    final result = await forgotPasswordUseCase(email);
    result.fold(
      (failure) {
        emit(AuthError(failure.message));
      },
      (message) {
        lastEmail = email; // Store for reset password
        emit(
          AuthSuccess(process: AuthProcess.forgotPassword, message: message),
        );
      },
    );
  }

  Future<void> resetPassword({required String code}) async {
    final email = lastEmail ?? emailController.text.trim();
    final newPassword = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || code.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      emit(AuthError("Please fill all fields"));
      return;
    }

    if (newPassword != confirmPassword) {
      emit(AuthError("Passwords do not match"));
      return;
    }

    emit(AuthLoading(AuthProcess.resetPassword));

    final result = await resetPasswordUseCase(
      email: email,
      code: code,
      newPassword: newPassword,
    );

    result.fold(
      (failure) {
        emit(AuthError(failure.message));
      },
      (message) {
        _clearControllers();
        emit(
          AuthSuccess(process: AuthProcess.resetPassword, message: message),
        );
      },
    );
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
