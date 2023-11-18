// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel {
//   String? uid;
//   String? name;
//   String? email;
//   String? imageUrl;
//   String? provider;

//   UserModel(
//       {this.uid,
//        this.name,
//        this.email,
//        this.imageUrl,
//        this.provider});

//   UserModel.fromJson(DocumentSnapshot snapshot) {
//     uid = snapshot['uid'];
//     name = snapshot['name'];
//     email = snapshot['email'];
//     imageUrl = snapshot['image_url'];
//     provider = snapshot['provider'];
//   }
// }

// Future<UserModel> getUserDataFromFirestore(String uid) async {
//   DocumentSnapshot snapshot =
//       await FirebaseFirestore.instance.collection('users').doc(uid).get();

//   return UserModel.fromJson(snapshot);
// }
