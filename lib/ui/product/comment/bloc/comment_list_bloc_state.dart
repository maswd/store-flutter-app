part of 'comment_list_bloc_bloc.dart';

sealed class CommentListState extends Equatable {
  const CommentListState();

  @override
  List<Object> get props => [];
}

final class CommentListLoading extends CommentListState {}

final class CommentListSucess extends CommentListState {
  final List<CommentEntity> comments;

  const CommentListSucess(this.comments);
  @override
  List<Object> get props => [comments];
}

final class CommentListError extends CommentListState {
  final AppException exception;
  const CommentListError(this.exception);
  @override
  // TODO: implement props
  List<Object> get props => [exception];
}
