import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instgramclone/model/user_model.dart';
import 'package:instgramclone/view/screen/users_profile.dart';
import 'package:instgramclone/view/widget/image_widget.dart';

class InstgramPostWidget extends StatelessWidget {
  final Users follower;
  final Users? currentUser;
  const InstgramPostWidget({
    super.key,
    required this.follower,
    this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: follower.posts!.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(
                    UserProfile(follower),
                    arguments: currentUser,
                  );
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 75,
                      height: 75,
                      child: CircleAvatar(
                        child: ClipOval(
                          child: ImageWidget(
                            imageUrl: follower.imageurl!,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        follower.firstname!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(follower.posts![index].postimageurl),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: const Text(";l;jl;j"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
