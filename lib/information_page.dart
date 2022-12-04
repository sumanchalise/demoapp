import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:demoapp/display_info_page.dart';
import 'package:demoapp/utils/local_data_source.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutYourselfController =
      TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  final LocalDataSource localDataSource = LocalDataSource();
  XFile? file;
  getImageFromGallery() async {
    file = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Fill up your details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  getImageFromGallery();
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                  child: file == null
                      ? const SizedBox()
                      : Image.file(
                          File(file!.path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Enter your name",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Enter your email",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "About yourself",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _aboutYourselfController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Skills",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _skillsController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_emailController.text == "" ||
                      _aboutYourselfController.text == "" ||
                      _nameController.text == "" ||
                      _skillsController.text == "" ||
                      file == null) {
                    final snackBar =
                        SnackBar(content: Text("Please fill the form."));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    Map<String, dynamic> data = {
                      "name": _nameController.text,
                      "email": _emailController.text,
                      "skills": _skillsController.text,
                      "about": _aboutYourselfController.text,
                      "imagePath": file!.path,
                    };
                    final encodedData = jsonEncode(data);
                    localDataSource.storeInformation(encodedData);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayInfoPage(
                          name: _nameController.text,
                          email: _emailController.text,
                          aboutYourSelf: _aboutYourselfController.text,
                          skills: _skillsController.text,
                          imagePath: file!.path,
                        ),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 50))),
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
