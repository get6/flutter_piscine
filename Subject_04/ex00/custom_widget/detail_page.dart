// ignore_for_file:
import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:subject/custom_widget/text95.dart';
import 'package:subject/models/comment.dart';

import '../models/post.dart';
import 'banner95.dart';

class DetailPage extends StatelessWidget {
  final Post post;
  const DetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold95(
      title: '${post.id + 1}번째 게시물 입니다.',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          children: [
            Elevation95(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Text95('제 목 : ${post.title}\n\n내 용 : ${post.body}'),
              ),
            ),
            const SizedBox(height: 10),
            Elevation95(
              child: SizedBox(
                height: 400,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(thickness: 1),
                  padding: EdgeInsets.zero,
                  itemCount: post.comments.length,
                  itemBuilder: (context, index) {
                    final Comment comment = post.comments.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text95(
                        '작성자 : ${comment.name}\n이메일 : ${comment.email}\n댓\t\t\t글 : ${comment.body}\n',
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Barnner95('▶︎ 전화 접속번호 변경 : 01421 -> 1544-1421'),
            const SizedBox(height: 10),
            const Barnner95('▶︎ 온라인 상담실 -> http://help.nownuri.net'),
            const SizedBox(height: 10),
            Image.asset('assets/images/nownuri.jpeg'),
          ],
        ),
      ),
    );
  }
}
