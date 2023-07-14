import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zola/models/comment_model.dart';
import 'package:zola/utils/datetime_formater.dart';
import 'package:zola/widgets/favorite_button.dart';

import 'package:zola/services/comment.dart' as comment_service;

import 'richtext_item.dart';

class CommentWidget extends StatefulWidget {
  final String id;
  final String username;
  final String fullname;
  final String avatarUrl;
  final String content;
  final String timeAgo;
  bool isFavorite;
  int favoriteCount;
  int replyCount;
  Function onReply;

  CommentWidget({
    super.key,
    required this.id,
    required this.username,
    required this.fullname,
    required this.avatarUrl,
    required this.content,
    required this.timeAgo,
    required this.isFavorite,
    this.favoriteCount = 0,
    this.replyCount = 0,
    required this.onReply,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool _isExpanded = false;
  List<CommentModel> listComment = [];
  List<CommentWidget> replies = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.avatarUrl),
            radius: 18.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.fullname,
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "@${widget.username}",
                  style: GoogleFonts.notoSans(color: Colors.grey),
                ),
                const SizedBox(height: 4.0),
                RichTextItem(
                  text: widget.content,
                ),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateTimeFormatterHelper.timeDifference(widget.timeAgo),
                      style: GoogleFonts.notoSans(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    TextButton(
                        onPressed: () => widget.onReply(),
                        child: Text(
                          'Phản hồi',
                          style: GoogleFonts.notoSans(
                              color: Colors.grey, fontSize: 12.0),
                        )),
                    const Spacer(),
                    Row(
                      children: [
                        FavoriteButton(
                          id: 'c_$widget.id',
                          isFavorite: widget.isFavorite,
                          onLike: () async {
                            try {
                              setState(() {
                                widget.isFavorite = !widget.isFavorite;
                                if (widget.isFavorite) {
                                  widget.favoriteCount++;
                                } else {
                                  widget.favoriteCount--;
                                }
                              });
                              await comment_service.likeComment(widget.id);
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        // number of like
                        Text(
                          '${widget.favoriteCount}',
                          style: GoogleFonts.notoSans(
                              color: Colors.grey, fontSize: 12.0),
                        ),
                      ],
                    )
                  ],
                ),

                // replies
                widget.replyCount == 0 && !_isExpanded
                    ? const SizedBox()
                    : _isExpanded
                        ? Container()
                        : TextButton(
                            onPressed: () async {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });

                              listComment =
                                  await comment_service.getReplies(widget.id);
                              // load replies from comment_service
                              List<CommentWidget> listRepliesWidget = [];
                              for (CommentModel comment in listComment) {
                                listRepliesWidget.add(CommentWidget(
                                  id: comment.id,
                                  username: comment.author.username,
                                  fullname: comment.author.fullname,
                                  avatarUrl: comment.author.avatarUrl,
                                  content: comment.content,
                                  timeAgo: comment.createdAt.toString(),
                                  isFavorite: comment.isLiked,
                                  favoriteCount: comment.totalLike,
                                  replyCount: comment.totalRely,
                                  onReply: () {
                                    widget.onReply();
                                  },
                                ));
                              }
                              setState(() {
                                _isExpanded = true;
                                replies = listRepliesWidget;
                              });
                            },
                            child: Text(
                              'Xem ${widget.replyCount} phản hồi',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                // hide replies if there are replies and not expanded
                if (replies.isNotEmpty && _isExpanded)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = false;
                      });
                    },
                    child: Text(
                      'Ẩn ${replies.length} phản hồi',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                //List replies with indent
                if (_isExpanded) ...replies.map((reply) => reply).toList(),
				const Divider()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
