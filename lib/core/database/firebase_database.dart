import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/firebase_options.dart';

class FirebaseDatabase {
  static final FirebaseDatabase _firebaseDatabase =
      FirebaseDatabase._internal();

  factory FirebaseDatabase() {
    return _firebaseDatabase;
  }

  FirebaseDatabase._internal();
  static late FirebaseFirestore firestore;


  static Future<void> init() async {
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    firestore = FirebaseFirestore.instance;
    printSuccess("Firebase Database Created");
  }
}
