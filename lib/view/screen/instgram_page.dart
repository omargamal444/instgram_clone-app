import 'package:flutter/material.dart';
import 'package:instgramclone/view/widget/instgram_post_widget.dart';

import '../../model/user_model.dart';

class InstgramPage extends StatelessWidget {
  final List<Users> users;
  final Users? currentUser;
  const InstgramPage({
    super.key,
    required this.users,
    this.currentUser,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instgram"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final follower = users[index];
                  return InstgramPostWidget(
                    follower: follower,
                    currentUser: currentUser,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
