import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/community/presentation/cubit/community_cubit.dart';
import 'package:thalorix_app/Features/community/presentation/cubit/community_state.dart';
import 'package:thalorix_app/Features/community/presentation/widgets/post_body.dart';
import 'package:thalorix_app/Features/community/presentation/widgets/switch_button.dart';
import 'package:thalorix_app/core/cache/cache_helper.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load feed when the view is initialized
    context.read<CommunityCubit>().getFeed();
  }

  void _onTabChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
    final cubit = context.read<CommunityCubit>();
    if (index == 0) {
      // All - show all posts
      cubit.getAll();
    } else {
      // Trending - posts from last hour
      cubit.getTrending();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.createPost).then((_) {
            // Refresh feed when coming back from create post
            context.read<CommunityCubit>().getFeed();
          });
        },
        backgroundColor: AppColors.splashPrimary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar - Community icon on left, centered title, no notification
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Community logo on the left
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.splashPrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.groups_rounded,
                      color: AppColors.splashPrimary,
                      size: 24,
                    ),
                  ),
                  // Centered title
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Community',
                        style: TextStyle(
                          color: Color(0xFF0D3B40),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                  // Invisible spacer to balance the left icon
                  const SizedBox(width: 40),
                ],
              ),
            ),

            // Tabs - All / Trending
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: SwitchButton(
                      text: "All",
                      index: 0,
                      selectedIndex: selectedIndex,
                      onTap: () => _onTabChanged(0),
                    ),
                  ),
                  Expanded(
                    child: SwitchButton(
                      text: "Trending",
                      index: 1,
                      selectedIndex: selectedIndex,
                      onTap: () => _onTabChanged(1),
                    ),
                  ),
                ],
              ),
            ),

            // Posts Feed
            Expanded(
              child: BlocConsumer<CommunityCubit, CommunityState>(
                listener: (context, state) {
                  if (state is CommunityError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  if (state is PostDeleted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CommunityLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.splashPrimary,
                      ),
                    );
                  }

                  if (state is CommunityError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 60,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<CommunityCubit>().getFeed();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.splashPrimary,
                            ),
                            child: const Text(
                              'Retry',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is CommunityLoaded) {
                    final posts = state.posts;

                    if (posts.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              selectedIndex == 1
                                  ? Icons.trending_up_rounded
                                  : Icons.forum_outlined,
                              size: 60,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              selectedIndex == 1
                                  ? 'No trending posts in the last hour.\nCheck back later!'
                                  : 'No posts yet.\nBe the first to share!',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      color: AppColors.splashPrimary,
                      onRefresh: () async {
                        await context.read<CommunityCubit>().getFeed();
                      },
                      child: ListView.separated(
                        padding: const EdgeInsets.only(
                          top: 4,
                          bottom: 80,
                          left: 12,
                          right: 12,
                        ),
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          final currentUserId = CacheHelper.getUserId();
                          final isMyPost =
                              currentUserId != null &&
                              currentUserId.isNotEmpty &&
                              post.userId == currentUserId;

                          return PostCard(
                            post: post,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.postDetails,
                                arguments: post,
                              ).then((_) {
                                // Refresh feed when coming back to update comments count
                                context.read<CommunityCubit>().getFeed();
                              });
                            },
                            onDelete: isMyPost
                                ? () => _showDeleteDialog(context, post.id)
                                : null,
                            onEdit: isMyPost
                                ? () => _showEditDialog(
                                    context,
                                    post.id,
                                    post.content,
                                    post.image,
                                  )
                                : null,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: posts.length,
                      ),
                    );
                  }

                  // Initial state - show loading
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.splashPrimary,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String postId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<CommunityCubit>().deletePost(id: postId);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    String postId,
    String currentContent,
    String? currentImage,
  ) {
    final contentController = TextEditingController(text: currentContent);
    final imageController = TextEditingController(text: currentImage ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Post'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: contentController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Edit your post...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.splashPrimary,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: imageController,
                decoration: InputDecoration(
                  hintText: 'Image URL (optional)',
                  prefixIcon: const Icon(
                    Icons.image_outlined,
                    color: AppColors.splashPrimary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.splashPrimary,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newContent = contentController.text.trim();
              final newImage = imageController.text.trim();
              if (newContent.isNotEmpty) {
                Navigator.pop(ctx);
                context.read<CommunityCubit>().updatePost(
                  id: postId,
                  content: newContent,
                  userId: CacheHelper.getUserId() ?? '',
                  image: newImage.isNotEmpty ? newImage : null,
                );
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(color: AppColors.splashPrimary),
            ),
          ),
        ],
      ),
    );
  }
}