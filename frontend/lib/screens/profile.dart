import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/updatedate_firsttimeuser.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String userEmail = "";
  String userName = "";
  String userLocation = "";

  XFile? _pickedImage;
  ImageProvider<Object>? _imageProvider; // Use ImageProvider<Object>? type

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage;
        _imageProvider =
            FileImage(File(pickedImage.path)); // Cast to ImageProvider<Object>
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch the user's email from Firebase Authentication
    final user = _auth.currentUser;
    if (user != null) {
      userEmail = user.email ?? "";
    }

    // Fetch user's name and location from Firestore
    _fetchUserData(user?.uid);
  }

  Future<void> _fetchUserData(String? userId) async {
    if (userId != null) {
      final userDoc = await _firestore.collection('bio').doc(userId).get();
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        setState(() {
          userName = data['name'] ?? "";
          userLocation = data['location'] ?? "";
        });
      }
    }
  }

  void _openUpdateForm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _updateDetails();
              Navigator.of(context).pop();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateDetails() async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      try {
        await _firestore.collection('bio').doc(userId).set({
          'name': _nameController.text,
          'location': _locationController.text,
        });
        setState(() {
          userName = _nameController.text;
          userLocation = _locationController.text;
        });
      } catch (e) {
        print('Error updating details: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Container(
              width: 200.0,
              height: 40,
              child: Icon(
                Icons.arrow_back,
                color: black,
                
              ),
            ),
            onPressed: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavScreen()));
            })),
        backgroundColor: Colors.white,
        elevation: 0,

        title: Text(
          "Update Profile",
          textScaleFactor: 0.8,
          style: TextStyle(color: black, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // GestureDetector(
            //   onTap: _pickImage,
            //   child: Center(
            //     child: CircleAvatar(
            //       radius: 50,
            //       backgroundImage: _imageProvider != null
            //           ? _imageProvider
            //           : AssetImage('lib/assets/girlsclock.jpg'), //
            //     ),
            //   ),
            // ),
            
            
            // Bio
            Text(
              "Bio",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 4.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(userEmail),
                  ),
                  ListTile(
                    title: Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(userName),
                  ),
                  ListTile(
                    title: Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(userLocation),
                    
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        
                      ),
                      
                      onPressed: _openUpdateForm,
                      child: Text('Update Details', style: TextStyle(color: primary),),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            // update dates
            Text(
              "First time user?\nAdd previous cycles dates (up to 3).",
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 4.0,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UpdateDateFormOverlay(),
                  ));
                },
                contentPadding: EdgeInsets.all(16.0),
                title: Container(
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(20),
                    color: primarylight,
                  ),
                  padding: EdgeInsets.all(16.0),
                  width: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Add Date",
                      style: TextStyle(color: black),),
                      Icon(Icons.add,
                      color: black,)
                    ],
                  ),
                ),
              ),
            ),
          ]),
    ));
  }
}
