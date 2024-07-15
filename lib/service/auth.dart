import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instgramclone/const.dart';
import 'package:instgramclone/view/screen/userdata.dart';
import 'package:instgramclone/view/widget/navbar.dart';

import '../model/post_model.dart';
import '../model/user_model.dart';

class Auth {
  Users? currentuser;
  List<String> c = <String>[].obs;
  int totalpostnumber = 0;
  List<String> _followers = [];
  List<Users> usersss = [];
  List<Post> _posts = [];
  int navbarindex = 0;
  int? doclength;
  List _comments = [];
  Map<String, dynamic>? daa;
  Users? users;
  List<Users> allusers = [];
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await getuserData(email: email);
      await getAllFollowers(users!);
      await getAllUsers(users!);
      await Get.offAll(Bottomnavbar(), arguments: [users, usersss, allusers]);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("message", "wrong email or password");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("message", "wrong email or password");
      }
    }

    return user;
  }

  signup(String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      final User user = credential.user!;
      Get.to(Userdata(), arguments: user.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Users> getuserData({@required String? email}) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection(Consts.users);
    final col = await reference.where("email", isEqualTo: email).get();
    List<QueryDocumentSnapshot> e = col.docs;
    try {
      for (var doc in col.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        daa = data;

        Users user = Users(
            secondname: data["secondname"],
            firstname: data["firstname"],
            id: data["id"],
            age: data["age"],
            email: data["email"],
            career: data["career"],
            imageurl: data["imageurl"],
            postnum: await getPostnum(data["id"]),
            followers: await getuserfollowers(data["id"]));
        users = user;
      }
    } catch (e) {
      print(e);
    }
    return users!;
  }

  Future<String> getPostnum(String id) async {
    String? postnum;
    final collectionref = FirebaseFirestore.instance.collection(Consts.users);
    await collectionref
        .doc(id)
        .collection(Consts.Posts)
        .get()
        .then((value) async {
      postnum = value.docs.length.toString();
      await collectionref.doc(id).update({"postnumber": postnum});
    });
    return postnum!;
  }

  Future<List> getuserfollowers(String id) async {
    List<String> followersids = [];
    followersids.clear();
    final collectionref = FirebaseFirestore.instance.collection(Consts.users);
    await collectionref
        .doc(id)
        .collection("followers")
        .get()
        .then((value) async {
      value.docs.forEach((element) {
        followersids.add(element["id"]);
      });
    });
    return followersids;
  }

  Future<List<Users>> getAllFollowers(Users currentuser) async {
    List<Users> followerrs = [];
    CollectionReference ref =
        FirebaseFirestore.instance.collection(Consts.users);
    var e = await ref.doc(currentuser.id).collection("followers").get();
    _followers.clear();
    for (var follower in e.docs) {
      _followers.add(follower["id"]);
    }
    usersss.clear();
    for (var follower in _followers) {
      _posts.clear();
      var q = await ref.doc(follower).get();
      var followerposts = await ref
          .doc(follower)
          .collection(Consts.Posts)
          .get(); // for(var followerpost in followerposts){}
      List postsoffollower = followerposts.docs;
      for (var post in postsoffollower) {
        var comments = await ref
            .doc(follower)
            .collection(Consts.Posts)
            .doc(post.id)
            .collection("comments")
            .get();
        _posts.add(Post(
            postimageurl: post[Consts.postimageurl], comments: comments.docs));
      }
      Users _user = Users(
          postnum: q["postnumber"],
          imageurl: q["imageurl"],
          email: q["email"],
          id: q["id"],
          career: q['career'],
          age: q["age"],
          secondname: q["secondname"],
          firstname: q["firstname"],
          posts: List.from(_posts));
      followerrs.add(_user);
      usersss = followerrs;
    }
    return usersss;
  }

  Future<List<Users>> getAllUsers(Users currentuser) async {
    allusers.clear();
    CollectionReference ref =
        FirebaseFirestore.instance.collection(Consts.users);
    var y = await ref.get();
    y.docs.forEach((element) {
      if (currentuser.firstname == element["firstname"]) {
      } else {
        Users users = Users(
            postnum: element["postnumber"],
            imageurl: element["imageurl"],
            id: element["id"],
            firstname: element["firstname"]);
        allusers.add(users);
      }
    });
    return allusers;
  }
}
