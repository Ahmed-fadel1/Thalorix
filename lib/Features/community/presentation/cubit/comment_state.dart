import 'package:thalorix_app/Features/community/data/models/comment_model.dart';

abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentsLoading extends CommentState {}

class CommentsLoaded extends CommentState {
  final List<CommentModel> comments;

  CommentsLoaded(this.comments);
}

class CommentError extends CommentState {
  final String message;

  CommentError(this.message);
}

class CommentAdding extends CommentState {}

class CommentAdded extends CommentState {
  final String message;

  CommentAdded(this.message);
}

class CommentUpdated extends CommentState {
  final String message;

  CommentUpdated(this.message);
}

class CommentDeleted extends CommentState {
  final String message;

  CommentDeleted(this.message);
}
