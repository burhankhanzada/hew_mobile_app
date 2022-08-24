import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'header.dart';
import 'options/options.dart';

const c1 = Color(0xFF00569d);
const c2 = Color(0xFF00a64d);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: const Text('Sign out'),
                onTap: () {
                  // userRef().onValue.drain();
                  FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: const [
          Header(),
          Options(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
        ],
        selectedItemColor: c2,
      ),
    );
  }
}
