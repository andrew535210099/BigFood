import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_selector/file_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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

  Future<void> _pickImage(BuildContext context) async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: ['jpg', 'jpeg', 'png'],
    );

    final List<XFile> pickedImages = await openFiles(
      acceptedTypeGroups: [typeGroup],
    );

    if (pickedImages != null && pickedImages.isNotEmpty) {
      setState(() {
        imagePath = pickedImages[0].path;
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
        await user.updatePhotoURL(imagePath);
        print('Foto profil berhasil diunggah');
        
        // Dapatkan referensi dokumen pengguna berdasarkan email
        var usersRef = FirebaseFirestore.instance.collection('users');
        var querySnapshot = await usersRef.where('email', isEqualTo: email).get();

        // Perbarui URL foto profil di Firestore
        if (querySnapshot.docs.isNotEmpty) {
          var doc = querySnapshot.docs.first;
          await doc.reference.update({'photoURL': imagePath});
        }
      } catch (error) {
        print('Gagal mengunggah foto profil: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 194, 191, 191),
                ),
                child: RawMaterialButton(
                  onPressed: () {
                    _pickImage(context);
                  },
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(24.0),
                  child: Icon(
                    Icons.person,
                    size: 150.0,
                    color: Color.fromARGB(255, 117, 116, 116),
                  ),
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
                  Navigator.pushNamed(context, '/setlocationpage');
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
