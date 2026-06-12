import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/community/data/data_sources/community_remote_data_source.dart';
import 'package:thalorix_app/Features/community/data/models/post_model.dart';
import 'package:thalorix_app/Features/community/data/repositories/community_repository_impl.dart';
import 'package:thalorix_app/Features/community/domain/usecases/add_comment_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/delete_comment_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/get_comments_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/update_comment_usecase.dart';
import 'package:thalorix_app/Features/community/presentation/cubit/comment_cubit.dart';
import 'package:thalorix_app/Features/community/presentation/cubit/comment_state.dart';
import 'package:thalorix_app/Features/community/presentation/widgets/comment_card.dart';
import 'package:thalorix_app/Features/community/presentation/widgets/post_body.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/cache/cache_helper.dart';

class PostDetailsView extends StatefulWidget {
  final PostModel post;

  const PostDetailsView({super.key, required this.post});

  @override
  State<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
  final _commentController = TextEditingController();
  late int _liveCommentsCount;

  @override
  void initState() {
    super.initState();
    _liveCommentsCount = widget.post.commentsCount;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = CommunityRepositoryImpl(CommunityRemoteDataSource());

    return BlocProvider(
      create: (context) => CommentCubit(
        getCommentsUseCase: GetCommentsUseCase(repo),
        addCommentUseCase: AddCommentUseCase(repo),
        updateCommentUseCase: UpdateCommentUseCase(repo),
        deleteCommentUseCase: DeleteCommentUseCase(repo),
      )..getComments(postId: widget.post.id),
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F2F5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0D3B40)),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Post',
            style: TextStyle(
              color: Color(0xFF0D3B40),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Post + Comments (scrollable)
            Expanded(
              child: BlocListener<CommentCubit, CommentState>(
                listener: (context, state) {
                  // Update comment count in real-time when comments are loaded
                  if (state is CommentsLoaded) {
                    setState(() {
                      _liveCommentsCount = state.comments.length;
                    });
                  }
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // The post itself - with live comment count
                      PostCard(
                        post: widget.post,
                        overrideCommentsCount: _liveCommentsCount,
                      ),

                      const SizedBox(height: 16),

                      // Comments section in a white card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Comments header with live count
                            Row(
                              children: [
                                const Text(
                                  'Comments',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0D3B40),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.splashPrimary
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '$_liveCommentsCount',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.splashPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // Comments list
                            BlocBuilder<CommentCubit, CommentState>(
                              builder: (context, state) {
                                if (state is CommentsLoading) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: CircularProgressIndicator(
                                        color: AppColors.splashPrimary,
                                      ),
                                    ),
                                  );
                                }

                                if (state is CommentError) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        state.message,
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ),
                                  );
                                }

                                if (state is CommentsLoaded) {
                                  if (state.comments.isEmpty) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(30),
                                        child: Column(
                                          children: [
                                            Icon(Icons.chat_bubble_outline,
                                                size: 40,
                                                color: Colors.grey.shade400),
                                            const SizedBox(height: 8),
                                            Text(
                                              'No comments yet',
                                              style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.comments.length,
                                    itemBuilder: (context, index) {
                                      return CommentCard(
                                        comment: state.comments[index],
                                      );
                                    },
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Comment input
            _buildCommentInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // User avatar
            CircleAvatar(
              radius: 16,
              backgroundColor:
                  AppColors.splashPrimary.withValues(alpha: 0.15),
              child: Text(
                (CacheHelper.getName() ?? 'U')[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.splashPrimary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _commentController,
                style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
                decoration: InputDecoration(
                  hintText: 'Write a comment...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF0F2F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            BlocConsumer<CommentCubit, CommentState>(
              listener: (context, state) {
                if (state is CommentAdded) {
                  _commentController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
                if (state is CommentError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is CommentAdding;
                return GestureDetector(
                  onTap: isLoading
                      ? null
                      : () {
                          final content = _commentController.text.trim();
                          if (content.isEmpty) return;

                          final userId = CacheHelper.getUserId() ?? '';
                          debugPrint(
                              '💬 Adding comment - userId: $userId, postId: ${widget.post.id}');

                          context.read<CommentCubit>().addComment(
                                postId: widget.post.id,
                                content: content,
                                userId: userId,
                              );
                        },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: AppColors.splashPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}