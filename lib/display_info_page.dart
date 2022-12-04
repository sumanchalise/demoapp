import 'dart:io';

import 'package:flutter/material.dart';
import 'package:demoapp/main.dart';
import 'package:demoapp/utils/local_data_source.dart';

class DisplayInfoPage extends StatelessWidget {
  final String name;
  final String email;
  final String aboutYourSelf;
  final String skills;
  final String imagePath;
  const DisplayInfoPage({
    required this.name,
    required this.email,
    required this.aboutYourSelf,
    required this.skills,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Portfolio"),
        actions: [
          IconButton(
              onPressed: () {
                LocalDataSource.clearInformation().then(
                  (value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false),
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(name),
                    Text(email),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "About Me",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              aboutYourSelf,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Skills",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              skills,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
