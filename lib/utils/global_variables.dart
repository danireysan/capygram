import 'package:capygram/screens/add_post_screen.dart';
import 'package:capygram/screens/feed_screen.dart';
import 'package:capygram/screens/profile_screen.dart';
import 'package:capygram/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  const Text('Favorite'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)
];
