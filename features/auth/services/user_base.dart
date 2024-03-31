import 'package:cloud_firestore/cloud_firestore.dart';

class UserBase{

  late FirebaseFirestore fireStore;

  fbInitialise() {
    fireStore = FirebaseFirestore.instance;
  }

  Future<void> addUser(String userId, String userName, String userPhone, int registrationDate) async {
    fbInitialise();
    try {
      await fireStore.collection('users').doc(userId).set({
        'userId': userId,
        'userName': userName,
        'userPhone': userPhone,
        'dateTime': registrationDate,
        'userRole': "userRole",
      });
    } catch (e) {
      print(e);
    }

  }
}