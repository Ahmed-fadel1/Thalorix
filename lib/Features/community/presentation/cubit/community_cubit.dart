import 'package:bloc/bloc.dart';
import 'package:thalorix_app/Features/community/data/models/post_model.dart';
import 'package:thalorix_app/Features/community/domain/usecases/create_post_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/delete_post_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/get_feed_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/update_post_usecase.dart';
import 'package:thalorix_app/Features/community/presentation/cubit/community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  final GetFeedUseCase getFeedUseCase;
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  List<PostModel> _posts = [];
  List<PostModel> get posts => _posts;

  CommunityCubit({
    required this.getFeedUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) : super(CommunityInitial());

  Future<void> getFeed() async {
    emit(CommunityLoading());

    final result = await getFeedUseCase();

    result.fold(
      (failure) => emit(CommunityError(failure.message)),
      (posts) {
        _posts = posts;
        emit(CommunityLoaded(posts));
      },
    );
  }

  Future<void> createPost({
    required String content,
    required String userId,
    String? image,
  }) async {
    emit(PostCreating());

    final result = await createPostUseCase(
      content: content,
      userId: userId,
      image: image,
    );

    result.fold(
      (failure) => emit(CommunityError(failure.message)),
      (message) {
        emit(PostCreated(message));
        // Refresh feed after creating a post
        getFeed();
      },
    );
  }

  Future<void> updatePost({
    required String id,
    required String content,
    required String userId,
    String? image,
  }) async {
    emit(CommunityLoading());

    final result = await updatePostUseCase(
      id: id,
      content: content,
      userId: userId,
      image: image,
    );

    result.fold(
      (failure) => emit(CommunityError(failure.message)),
      (message) {
        emit(PostUpdated(message));
        // Refresh feed after updating
        getFeed();
      },
    );
  }

  Future<void> deletePost({required String id}) async {
    emit(CommunityLoading());

    final result = await deletePostUseCase(id: id);

    result.fold(
      (failure) => emit(CommunityError(failure.message)),
      (message) {
        _posts.removeWhere((post) => post.id == id);
        emit(PostDeleted(message));
        emit(CommunityLoaded(_posts));
      },
    );
  }
}
