import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instgramclone/const.dart';
import 'package:instgramclone/controller/userprofilecontroller.dart';
import 'package:instgramclone/view/screen/profile.dart';
import 'package:instgramclone/view/screen/usersprofile.dart';
import '../../model/usermodel.dart';
import 'package:get/get.dart';
class Instgrampage extends StatelessWidget {
  List<Users> usersss;
  Users ?currentuser;
 Instgrampage({@required this.currentuser
   ,required this.usersss
 });
  @override
  Widget build(BuildContext context) {
    print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    print(usersss.length);
    print(usersss[1].posts!.length);
    print(usersss[0].posts!.length);
    return Scaffold(appBar: AppBar(title: const Text("Instgram"
    ),
    ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: usersss.length
          ,itemBuilder: (context, index) {
                final follower =usersss[index];
                return
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),

                      itemCount: follower.posts!.length
                      ,itemBuilder: (context, index) {
                      return Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(onTap: (){
                            Get.to(Userprofiles(follower),arguments: currentuser);
                          },
                            child: Row(children: [
                              SizedBox(
                                width: 75,
                                height: 75,
                                child: CircleAvatar(
                                  child: ClipOval(
                                      child:checkUrl(follower.imageurl!)
                                  ),
                                ),
                              )
                              ,Padding(
                                padding: const EdgeInsets.only(left: 20 ),
                                child: Text(follower.firstname!,style: TextStyle(fontWeight: FontWeight.bold),),
                              )],),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(height: 300,child:Text(";l;jl;j"),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(follower.posts![index].postimageurl),
                                  fit: BoxFit.fill,
                                ),
                              ),),
                          ),
                        ],
                      );
                    },),
                  );
              },),
            ),


/*

            StreamBuilder(
              stream: FirebaseFirestore.instance.collection(Consts.users).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                if (!snapshot.hasData) return CircularProgressIndicator();

                return SizedBox(
                  child: ListView.builder(shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                    //  var documentID = snapshot.data!.docs[index].id;
                       String documentID=users[index].id!;
                     Users user=Users(
                         firstname:users[index].firstname,
                     secondname: snapshot.data!.docs[index]["secondname"],
                       imageurl:users[index].imageurl,
                       email: snapshot.data!.docs[index]["email"],
                       age: snapshot.data!.docs[index]["age"],
                       career: snapshot.data!.docs[index]["career"],
                      postnum: snapshot.data!.docs[index]['postnumber'],
                      id: snapshot.data!.docs[index]["id"]
                     );

                     return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(Consts.users)
                            .doc(documentID)
                            .collection(Consts.Posts)
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> subSnapshot) {
                          print(subSnapshot.data!.docs.length);
                          if (!subSnapshot.hasData) return CircularProgressIndicator();

                          doclength=subSnapshot.data!.docs.length;
               return SizedBox(
                 child: ListView.builder(
                     physics: NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                itemCount: users
                // itemCount: subSnapshot.data!.docs.length
                 ,itemBuilder: (context, index) {
                     final url=subSnapshot.data!.docs[index][Consts.postimageurl];
                     return Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                       children: [
                     GestureDetector(onTap: (){
                       Get.to(Userprofiles(user));                     },
                       child: Row(children: [
                         SizedBox(
                         width: 75,
                         height: 75,
                         child: CircleAvatar(
                           child: ClipOval(
                               child:checkUrl(user.imageurl!)
                           ),
                         ),
                       )
                         ,Padding(
                           padding: const EdgeInsets.only(left: 20 ),
                           child: Text(user.firstname!,style: TextStyle(fontWeight: FontWeight.bold),),
                         )],),
                     ),
                         Padding(
                           padding: const EdgeInsets.only(top: 20),
                           child: Container(height: 300,child:Text(";l;jl;j"),
                                   decoration: BoxDecoration(
                                   image: DecorationImage(
                                   image: NetworkImage(url),
                   fit: BoxFit.fill,
                   ),
                   ),),
                         ),
                       ],
                     );
                 },
                 ),
               );
                          // Your widget that displays subcollection data
                        },
                      );
                    },
                    itemCount:totalpostnumber
                    //snapshot.data!.docs.length,
                  ),
                );
              },
            ),
            */
          ],
        ),
      )
       );
  }
}
