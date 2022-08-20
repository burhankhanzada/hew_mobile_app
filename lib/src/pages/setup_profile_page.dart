import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../state/app_state.dart';
import '../utils/firebase_utils.dart';
import 'home/home_page.dart';

class SetupProfilePage extends StatefulWidget {
  const SetupProfilePage({super.key});

  @override
  State<SetupProfilePage> createState() => _SetupProfilePageState();
}

class _SetupProfilePageState extends State<SetupProfilePage> {
  final nameController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final nameField = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Name'),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(filled: true),
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: isLoading ? const CircularProgressIndicator() : nameField,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () async {
          setState(() {
            isLoading = true;
          });

          final name = nameController.text;

          final user = FirebaseAuth.instance.currentUser;

          await user!.updateDisplayName(name);

          final uid = user.uid;

          final userModel = UserModel(
            userId: uid,
            displayName: name,
            phoneNumber: user.phoneNumber!,
            userName: name.trim().replaceAll(' ', '').toLowerCase(),
          );

          await userRef(uid).set(userModel.toMap());

          if (!mounted) return;

          context.read<AppState>().userModel = userModel;

          await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<void>(builder: (contex) => const HomePage()),
            (route) => false,
          );
        },
      ),
    );
  }
}
