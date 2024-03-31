
class UserFbs {
  String? id;

  UserFbs.fromFirebase(fUser){
    id = fUser.uid;
  }
}