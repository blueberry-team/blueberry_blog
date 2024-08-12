import 'package:flutter/material.dart';

import 'widget/FriendsListWidget.dart';

class FriendsListScreen extends StatelessWidget {
  static const String name = 'FriendsListScreen';

  const FriendsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: FriendsListWidget()),
          ],
        ),
      ),
    );
  }
}
