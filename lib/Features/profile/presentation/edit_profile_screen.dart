import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/profile/presentation/cubit/cubit/user_update_cubit.dart';
import 'package:thalorix_app/Features/profile/presentation/cubit/cubit/user_update_state.dart';
import 'package:thalorix_app/Features/profile/presentation/widgets/custom_field.dart';
import 'package:thalorix_app/Features/security/presentation/security_settings_screen.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';

class EditProfileScreen extends StatefulWidget {
  final String userId;
  const EditProfileScreen({super.key, required this.userId});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void initState() {
    Future.microtask(() {
      context.read<UserCubit>().getUserData(widget.userId);
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserDataLoaded) {
          _nameController.text = state.user.name ?? '';
          _emailController.text = state.user.email ?? '';
          _phoneController.text = state.user.phone ?? '';
          _bioController.text = state.user.bio ?? '';
        }
        if (state is UserUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 10),
                  Text("Profile updated successfully"),
                ],
              ),
              backgroundColor: Colors.greenAccent[700],
              duration: const Duration(seconds: 3),
            ),
          );
        }
        if (state is UserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final user = context.read<UserCubit>().currentUser;
        return Scaffold(
          backgroundColor: const Color(0xffF5F7F6),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border, width: 2),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
            title: const Text(
              "Profile Settings",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            actions: [
              state is UserLoading
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        context.read<UserCubit>().updateUser(
                          userId: widget.userId,
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          phone: _phoneController.text.trim(),
                          bio: _bioController.text.trim(),
                        );
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: user?.profilePic != null
                            ? NetworkImage(user!.profilePic!)
                            : null,
                        child: user?.profilePic == null
                            ? const Icon(Icons.person, size: 50, color: Colors.white)
                            : null,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final result = await FilePicker.pickFiles(type: FileType.image);
                          if (result != null && result.files.single.path != null) {
                            context.read<UserCubit>().uploadProfilePic(
                                  imagePath: result.files.single.path!,
                                  slug: widget.userId, // Using user ID as slug per common practice
                                  userId: widget.userId,
                                );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.teal,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "Tap camera icon to change avatar\nMax size: 5MB",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.iconbutton),
                  ),
                ),
                const SizedBox(height: 30),
                CustomField(
                  label: "Full name",
                  hint: user?.name ?? "Loading...",
                  controller: _nameController,
                ),
                const SizedBox(height: 12),
                CustomField(
                  label: "Email",
                  hint: user?.email ?? "Loading...",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                CustomField(
                  label: "Phone Number",
                  hint: user?.phone ?? "Loading...",
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                CustomField(
                  label: "Bio",
                  hint: user?.bio ?? "Loading...",
                  controller: _bioController,
                  maxLines: 3,
                ),

                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.security);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.security),
                        SizedBox(width: 8),
                        Text(
                          "Security Settings",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
