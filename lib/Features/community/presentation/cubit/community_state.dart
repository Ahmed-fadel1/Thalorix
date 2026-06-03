import 'package:thalorix_app/Features/community/data/models/post_model.dart';

abstract class CommunityState {}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunityLoaded extends CommunityState {
  final List<PostModel> posts;

  CommunityLoaded(this.posts);
}

class CommunityError extends CommunityState {
  final String message;

  CommunityError(this.message);
}

class PostCreating extends CommunityState {}

class PostCreated extends CommunityState {
  final String message;

  PostCreated(this.message);
}

class PostUpdated extends CommunityState {
  final String message;

  PostUpdated(this.message);
}

class PostDeleted extends CommunityState {
  final String message;

  PostDeleted(this.message);
}
