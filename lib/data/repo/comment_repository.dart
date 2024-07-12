import 'package:store/common/http_client.dart';
import 'package:store/data/comment.dart';
import 'package:store/data/source/comment_data_source.dart';

final commentRepository =
    CommentRepository((CommentsRemoteDataSource(httpClient)));

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository(this.dataSource);
  @override
  Future<List<CommentEntity>> getAll({required int productId}) =>
      dataSource.getAll(productId: productId);
}
