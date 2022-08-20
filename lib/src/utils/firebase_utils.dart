import 'package:firebase_database/firebase_database.dart';

final database = FirebaseDatabase.instance..setPersistenceEnabled(true);

final usersRef = database.ref('users');

DatabaseReference userRef(String uid) => usersRef.child(uid);
