import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:demoapp/display_info_page.dart';
import 'package:demoapp/information_page.dart';
import 'package:demoapp/utils/local_data_source.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Navigation());
  }
}

class Navigation extends StatelessWidget {
  final LocalDataSource localDataSource = LocalDataSource();

  Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: localDataSource.getInformation(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final result = snapshot.data;
          print("result: $result");
          if (result != "") {
            Map<String, dynamic> decodedData = jsonDecode(result!);
            return DisplayInfoPage(
              name: decodedData['name'],
              email: decodedData['email'],
              aboutYourSelf: decodedData['about'],
              skills: decodedData['skills'],
              imagePath: decodedData['imagePath'],
            );
          } else {
            return const HomePage();
          }
        }
        return Container();
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Portfolio App"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // push to next page
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const InformationPage()));
          },
          child: Text("Get Started"),
        ),
      ),
    );
  }
}
