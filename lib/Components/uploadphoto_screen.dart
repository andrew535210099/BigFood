import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_selector/file_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: UploadProfilePage(),
  ));
}

class UploadProfilePage extends StatefulWidget {
  @override
  _UploadProfilePageState createState() => _UploadProfilePageState();
}

class _UploadProfilePageState extends State<UploadProfilePage> {
  late String imagePath;
  String? photoURL;

  Future<void> _pickImage(BuildContext context) async {
  final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    setState(() {
      imagePath = pickedImage.path;
      print(imagePath);
    });

    await _uploadProfilePhoto();
  }
}


  Future<void> _uploadProfilePhoto() async {
    User? user = FirebaseAuth.instance.currentUser;
    final email = user?.email;
    if (user != null) {
      
      try {

        FirebaseStorage storage = FirebaseStorage.instance;

        Reference storageRef = storage.ref().child('profile_photos/${user.uid}.jpg');
            
        File imageFile = File(imagePath);
        
        if (imageFile.existsSync()) {

          UploadTask uploadTask = storageRef.putFile(imageFile);
          TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
          String downloadURL = await snapshot.ref.getDownloadURL();

          await user.updatePhotoURL(downloadURL);
          print('Foto profil berhasil diunggah');

          var usersRef = FirebaseFirestore.instance.collection('users');
          var querySnapshot = await usersRef.where('email', isEqualTo: email).get();

          if (querySnapshot.docs.isNotEmpty) {
            var doc = querySnapshot.docs.first;  
            await doc.reference.update({'photoURL': downloadURL});
          }

          getUserPhotoURL();
        } else {
          print('File gambar tidak ditemukan');
        }
      } catch (error) {
        print('Gagal mengunggah foto profil: $error');
      }
    }
  }

  Future<void> getUserPhotoURL() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        photoURL = user.photoURL;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserPhotoURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 100, 64),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Upload Photo'),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Upload your photo \nprofile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'This data will be displayed in your \naccount profile for security',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 80.0),
              Container(
                width: 200.0,
                height: 200.0,
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 194, 191, 191),
                  radius: 100.0,
                  backgroundImage: photoURL != null ? NetworkImage(photoURL!) : null,
                  child: photoURL == null
                      ? Icon(
                          Icons.person,
                          size: 150.0,
                          color: Color.fromARGB(255, 117, 116, 116),
                        )
                      : null,
                ),
              ),
              SizedBox(height: 40.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  UploadProfile(
                    onPressed: () {
                      _pickImage(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/homebar',
                    arguments: {'currentIndex': 3}, // Pindah ke tab ke-2 (indeks 1)
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(int.parse('FF6440', radix: 16)).withOpacity(1.0),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadProfile extends StatelessWidget {
  const UploadProfile({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          primary: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 100.0),
        ),
        child: Center(
          child: Text(
            'Replace or edit image',
            style: TextStyle(fontSize: 15.0, color: Color.fromRGBO(255, 100, 64, 1)),
          ),
        ),
      ),
    );
  }
}
