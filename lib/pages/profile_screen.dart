import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  void _uploadProfilePicture() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final storageRef =
          FirebaseStorage.instance.ref().child('profiles/${image.name}');
      await storageRef.putFile(File(image.path));
    }
  }

  void _saveProfileDetails() async {
    await FirebaseFirestore.instance.collection('profiles').doc('user_id').set({
      'name': _nameController.text,
      'profile_picture': 'path_to_uploaded_image',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            ElevatedButton(
              onPressed: _uploadProfilePicture,
              child: Text("Upload Profile Picture"),
            ),
            ElevatedButton(
              onPressed: _saveProfileDetails,
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
