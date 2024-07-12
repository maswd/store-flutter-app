import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/data/comment.dart';
import 'package:store/data/repo/comment_repository.dart';
import 'package:store/ui/product/comment/bloc/comment_list_bloc_bloc.dart';
import 'package:store/ui/widgets/error.dart';

class CommentList extends StatelessWidget {
  final int productId;

  const CommentList({super.key, required this.productId});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final CommentListBloc bloc = CommentListBloc(
            productId: productId, repository: commentRepository);
        bloc.add(CommenetListStarted());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
        builder: (context, state) {
          if (state is CommentListSucess) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return CommentItem(
                    comment: state.comments[index],
                  );
                },
                childCount: state.comments.length,
              ),
            );
          } else if (state is CommentListLoading) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CommentListError) {
            return SliverToBoxAdapter(
                child: AppErrorWidget(
                    exception: state.exception,
                    onPressed: () {
                      BlocProvider.of<CommentListBloc>(context)
                          .add(CommenetListStarted());
                    }));
          } else {
            throw Exception("state not supported");
          }
        },
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
          borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.title,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(fontWeightDelta: 1),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    comment.email,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              Text(comment.date, style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(comment.content),
        ],
      ),
    );
  }
}
