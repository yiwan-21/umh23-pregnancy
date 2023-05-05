import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Ultrasound extends StatefulWidget {
  const Ultrasound({super.key});

  @override
  State<Ultrasound> createState() => _UltrasoundState();
}

class _UltrasoundState extends State<Ultrasound> {
  File? _image;

  // Pick from gallery
  void gallaryImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

// Pick from camera
  void cameraImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ultrasound'),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 20.0),
            Text(
              _image == null ? 'No image selected' : 'Image selected:',
              textAlign: TextAlign.center,
            ),
            if (_image != null)
              Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: FileImage(_image!),
                ),
              ),
            const SizedBox(height: 40.0),
            TextButton.icon(
              onPressed: cameraImage,
              label: const Text(
                'Camera',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              icon: const Icon(
                Icons.add_a_photo,
              ),
            ),
            TextButton.icon(
              onPressed: gallaryImage,
              label: const Text(
                'Gallery',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              icon: const Icon(Icons.image),
            ),
          ],
        ));
  }
}
