import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instgramclone/view/screen/profile.dart';
import '../../const.dart';
import '../../controller/userprofilecontroller.dart';
import '../../model/usermodel.dart';

class Userprofiles extends StatelessWidget {
 // List<String> followersidss=[];
  //final _userprofilecontroller=Get.find<Userprofilecontroller>();
  Users follower;
  Userprofiles(this.follower);
  @override
  Widget build(BuildContext context) {
   Users _currentuser=Get.arguments;
    return DefaultTabController(length: 2,
        child: Scaffold(body: Column(children: [

          Padding(
            padding: const EdgeInsets.all(20),
            child: Container( height: MediaQuery.of(context).size.height/2  ,width: 420,
              child: Column(
                children: [
                  SingleChildScrollView(scrollDirection: Axis.horizontal,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        details("متابعه","1"),
                        details("متابعين","1"),
                        details("منشورات",follower.postnum!),
                        GestureDetector(onTap: (){

                        },
                            child: Padding(padding: EdgeInsets.only(right: 30),
                                child: Column(
                                  children: [

                                    SizedBox(
                                      width: 75,
                                      height: 75,
                                      child: CircleAvatar(
                                        child: ClipOval(
                                            child:checkUrl(follower.imageurl!)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10,bottom: 10),
                                      child: Text(follower.firstname!,
                                        style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                    Text(follower.career!),
                                    Text("${follower.age}years")
                                  ],
                                ))),


                      ],
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                    IconButton(onPressed: (){},icon:Icon(Icons.person_add_alt_1_sharp)),
                    Padding(
                      padding: const EdgeInsets.only(left: 120,right: 100),
                      child: GestureDetector(onTap: ()async{
                      },
                        child: Container(
                        color: Colors.blue
                        ,child: Padding(
                          padding: const EdgeInsets.all(10),
                          child:
                            Text(
                              _currentuser.followers!.contains(follower.id)?
                                "followed":"follow",
                              style: TextStyle(fontWeight: FontWeight.bold
                            ,fontSize: 25),),

                        ),),
                      ),
                    )
                  ],),

                ],

              ),

            ),
          ),
          const TabBar(tabs: [Tab(icon:Icon (Icons.video_camera_back,color: Colors.black,)),
            Tab(icon:Icon (Icons.video_camera_front,color: Colors.black))]
          ),
          Expanded(
            child: TabBarView(children: [
              StreamBuilder(stream:FirebaseFirestore.instance.collection(Consts.users).doc(follower.id)
                  .collection(Consts.Posts).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData){
                      return Text("loading");

                    }
                    return
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          //  postnum.value =snapshot.data!.docs.length;
                          final imageurl=snapshot.data!.docs[index][Consts.postimageurl];
                          return Container(child: Image.network(imageurl),);},

                      );
                  }),
              Center(child: Text("mohammed"))
            ]),
          )


        ],),

        ),
    );

  }

}
Widget details(String name,String number){
  return  Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
      children: [
        Text(name,style: TextStyle(fontSize: 20)),
        Text("$number")
      ],
    ),
  );
}
