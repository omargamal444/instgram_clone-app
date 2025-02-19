import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instgramclone/controller/profile_controller.dart';

import '../../const.dart';
import '../../model/user_model.dart';

class Profile extends StatelessWidget {
  final _profilecontroller = Get.find<Profilecontroller>();
  Users _users;
  List<Users>? users;
  Profile(this._users, {this.users});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: 420,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            details("متابعه", "1"),
                            details("متابعين", "1"),
                            details("منشورات", _users.postnum!),
                            GestureDetector(
                                onTap: () {},
                                child: Padding(
                                    padding: EdgeInsets.only(right: 30),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 75,
                                          height: 75,
                                          child: CircleAvatar(
                                            child: ClipOval(
                                                child:
                                                    checkUrl(_users.imageurl!)),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Text(
                                            _users.firstname!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(_users.career!),
                                        Text("${_users.age}years")
                                      ],
                                    ))),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.person_add_alt_1_sharp)),
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 40),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              width: 250,
                              height: 50,
                              child: Center(
                                  child: Text(
                                "تعديل الملف الشخصى",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          child: ListView.builder(
                            itemCount: users!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Container(
                                    height: 130,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 75,
                                            height: 60,
                                            child: CircleAvatar(
                                              child: ClipOval(
                                                  child: checkUrl(
                                                      users![index].imageurl!)),
                                            ),
                                          ),
                                          Text(users![index].firstname!),
                                          GestureDetector(
                                            onTap: () async {
                                              await addfollower(
                                                  curerntuser: _users,
                                                  index: index);
                                              _profilecontroller.follow.value =
                                                  "followed";
                                              print("done");
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 100,
                                              color: Colors.blue,
                                              child: Center(
                                                  child: _users.followers!
                                                          .contains(
                                                              users![index].id)
                                                      ? Text(
                                                          "followed",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 25),
                                                        )
                                                      : Obx(() => Text(
                                                            _profilecontroller
                                                                .follow.value,
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            },
                          ),
                          height: 130,
                          width: 350,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const TabBar(tabs: [
                Tab(
                    icon: Icon(
                  Icons.video_camera_back,
                  color: Colors.black,
                )),
                Tab(icon: Icon(Icons.video_camera_front, color: Colors.black))
              ]),
              Expanded(
                child: TabBarView(children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(Consts.users)
                          .doc(_users.id)
                          .collection(Consts.Posts)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text("loading");
                        }
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            //  postnum.value =snapshot.data!.docs.length;
                            final imageurl =
                                snapshot.data!.docs[index][Consts.postimageurl];
                            return Container(
                              child: Image.network(imageurl),
                            );
                          },
                        );
                      }),
                  Center(child: Text("mohammed"))
                ]),
              )
            ],
          ),
        ));
  }

  Future<void> addfollower(
      {@required Users? curerntuser, @required int? index}) async {
    CollectionReference ref =
        FirebaseFirestore.instance.collection(Consts.users);
    DocumentReference docref = ref.doc(curerntuser!.id);
    if (curerntuser.followers!.contains(users![index!].id)) {
    } else {
      docref.collection("followers").add({"id": users![index].id});
    }
  }
}

Widget details(String name, String number) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
      children: [Text(name, style: TextStyle(fontSize: 20)), Text("$number")],
    ),
  );
}

Widget checkUrl(String url) {
  try {
    return Image.network(url, height: 70.0, width: 70.0, fit: BoxFit.fill);
  } catch (e) {
    return const Icon(Icons.image);
  }
}
