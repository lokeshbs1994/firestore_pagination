import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_pagination/model/post.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    uploadRandom();
  }

  void uploadRandom() async {
    final postCollection =
        FirebaseFirestore.instance.collection('posts').withConverter(
              fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
              toFirestore: (post, _) => post?.toJson(),
            );
    final numbers = List.generate(500, (index) => index + 1);

    for (final number in numbers) {
      final post = Post(
        title: 'Random Title $number',
        likes: Random().nextInt(1000),
        createdAt: DateTime.now(),
        imageUrl: 'https://source.unsplash.com/random?sig=$number',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Pagination'),
        centerTitle: true,
      ),
    );
  }
}
