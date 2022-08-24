import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final user = FirebaseAuth.instance.currentUser!;

final database = FirebaseDatabase.instance..setPersistenceEnabled(true);

final usersRef = database.ref('users');

DatabaseReference userRef() => usersRef.child(user.uid);
