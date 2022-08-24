import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../models/user_model.dart';
import '../utils/firebase_utils.dart';

class AppState extends ChangeNotifier {
  AppState() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _getUserModel();
      notifyListeners();
    });
  }

  User? user;

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  set userModel(UserModel? userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  Future<void> _getUserModel() async {
    user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final snapshot = await userRef().get();

      if (snapshot.exists) {
        final map = snapshot.value! as Map<dynamic, dynamic>;

        _userModel = UserModel.fromMap(map);
      }
    }

    notifyListeners();
  }
}
