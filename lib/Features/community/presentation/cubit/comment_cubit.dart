import 'package:bloc/bloc.dart';
import 'package:thalorix_app/Features/community/data/models/comment_model.dart';
import 'package:thalorix_app/Features/community/domain/usecases/add_comment_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/delete_comment_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/get_comments_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/update_comment_usecase.dart';
import 'package:thalorix_app/Features/community/presentation/cubit/comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final GetCommentsUseCase getCommentsUseCase;
  final AddCommentUseCase addCommentUseCase;
  final UpdateCommentUseCase updateCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;

  List<CommentModel> _comments = [];
  List<CommentModel> get comments => _comments;

  CommentCubit({
    required this.getCommentsUseCase,
    required this.addCommentUseCase,
    required this.updateCommentUseCase,
    required this.deleteCommentUseCase,
  }) : super(CommentInitial());

  Future<void> getComments({required String postId}) async {
    emit(CommentsLoading());

    final result = await getCommentsUseCase(postId: postId);

    result.fold(
      (failure) => emit(CommentError(failure.message)),
      (comments) {
        _comments = comments;
        emit(CommentsLoaded(comments));
      },
    );
  }

  Future<void> addComment({
    required String postId,
    required String content,
    required String userId,
  }) async {
    emit(CommentAdding());

    final result = await addCommentUseCase(
      postId: postId,
      content: content,
      userId: userId,
    );

    result.fold(
      (failure) => emit(CommentError(failure.message)),
      (message) {
        emit(CommentAdded(message));
        // Refresh comments after adding
        getComments(postId: postId);
      },
    );
  }

  Future<void> updateComment({
    required String id,
    required String content,
    required String userId,
    required String postId,
  }) async {
    emit(CommentsLoading());

    final result = await updateCommentUseCase(
      id: id,
      content: content,
      userId: userId,
    );

    result.fold(
      (failure) => emit(CommentError(failure.message)),
      (message) {
        emit(CommentUpdated(message));
        getComments(postId: postId);
      },
    );
  }

  Future<void> deleteComment({
    required String id,
    required String postId,
  }) async {
    emit(CommentsLoading());

    final result = await deleteCommentUseCase(id: id);

    result.fold(
      (failure) => emit(CommentError(failure.message)),
      (message) {
        _comments.removeWhere((c) => c.id == id);
        emit(CommentDeleted(message));
        emit(CommentsLoaded(_comments));
      },
    );
  }
}
