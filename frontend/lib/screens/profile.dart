import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';
import 'package:image_picker/image_picker.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  XFile? _pickedImage;
  ImageProvider<Object>? _imageProvider; // Use ImageProvider<Object>? type

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage;
        _imageProvider = FileImage(File(pickedImage.path)); // Cast to ImageProvider<Object>
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageProvider != null
                    ? _imageProvider 
                    : AssetImage('lib/assets/girlsclock.jpg'),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(primaryDark)),
              onPressed: () {
                //update logic 
              },
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
