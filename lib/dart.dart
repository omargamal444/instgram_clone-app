main(){
User user =User("mohamed",e,7);
User user2=User("omar", e,4);
user.m.add("8");
print(user2.m);
print(user.m);
user.y!*5;
print(user2.y);
print(user.y);



}
List e=[1,2,3,4,5];
class User{
  int?y=5;
  String? b;
  List m=[];
  User(this.b, this.m,this.y);
}
