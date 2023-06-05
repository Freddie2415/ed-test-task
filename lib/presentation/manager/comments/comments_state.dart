part of 'comments_cubit.dart';

@immutable
abstract class CommentsState {}

class CommentsInitial extends CommentsState {}

class CommentsLoading extends CommentsState {}

class CommentsFailure extends CommentsState {
  final String message;

  CommentsFailure(this.message);
}

class CommentsSuccess extends CommentsState {
  final List<CommentModel> comments;

  CommentsSuccess(this.comments);
}
