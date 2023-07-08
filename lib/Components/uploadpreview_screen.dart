import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../UserData/user_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'homebar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _user = _auth.currentUser!;
    final DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(_user.uid).get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.data() as Map<String, dynamic>;
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      setState(() {
        userProvider.setUsername(userData['username']);
        userProvider.setEmail(userData['email']);
      });
    }
  }

  void _signOut() async {
    await _auth.signOut();
    Navigator.pop(context); // Kembali ke halaman sebelumnya setelah logout
  }

  void _deleteAccount() async {
    try {
      // Hapus akun dari Firebase Authentication
      await _user.delete();

      // Hapus data pengguna dari Firestore
      await _firestore.collection('users').doc(_user.uid).delete();

      // Navigasi ke halaman login setelah menghapus akun
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      showCustomSnackBar('User deleted successfully', Color(int.parse('FF6440', radix: 16))); // Panggil metode showCustomSnackBar dengan pesan dan warna yang diinginkan
    } catch (e) {
      // Tangani error saat menghapus akun
      print('Failed to delete account: $e');
      // Tampilkan pesan kesalahan kepada pengguna, misalnya menggunakan SnackBar
      showCustomSnackBar('Failed to delete account. Please try again later.', Colors.red); // Panggil metode showCustomSnackBar dengan pesan dan warna yang diinginkan
    }
  }

  void _showConfirmationDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.5,
        widthFactor: 0.8,
        alignment: Alignment.center,
        child: Align(
          alignment: Alignment.center,
          child: AlertDialog(
            title: Text('Delete Account'),
            content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog konfirmasi
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  _deleteAccount(); // Panggil method _deleteAccount() untuk menghapus akun
                  Navigator.of(context).pop(); // Tutup dialog konfirmasi
                },
                child: Text('Delete'),
              ),
            ],
          ),
        ),
      );
    },
  );
}



  void showCustomSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          final username = userProvider.getUsername();
          final email = userProvider.getEmail();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 60.0,
                          backgroundImage: AssetImage('assets/bg-welcome.jpg'),
                        ),
                        SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              email,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(height: 10),
                            // Text(
                            //   'Nomor Telepon',
                            //   style: TextStyle(
                            //     fontSize: 18.0,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: 60,
                      right: 0,
                      child:GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: Icon(Icons.edit),
                      ),

                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.payment),
                      trailing: Icon(Icons.arrow_forward),
                      title: Text('Payment Method'),
                      onTap: () {
                        // Action when Payment Method is clicked
                        Navigator.pushNamed(context, '/payment');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_cart),
                      trailing: Icon(Icons.arrow_forward),
                      title: Text('My Orders'),
                      onTap: () {
                        // Action when My Orders is clicked
                        Navigator.pushNamed(
                          context,
                          '/homebar',
                          arguments: {'currentIndex': 1}, // Pindah ke tab ke-2 (indeks 1)
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.help),
                      trailing: Icon(Icons.arrow_forward),
                      title: Text('Help'),
                      onTap: () {
                        // Action when Help is clicked
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: _signOut,
                      child: Text('Log Out'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(int.parse('FF6440', radix: 16)).withOpacity(1.0), // Warna oranye
                        minimumSize: Size(double.infinity, 48.0),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _showConfirmationDialog,
                      child: Text('Delete Account'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // Warna abu-abu
                        minimumSize: Size(double.infinity, 48.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
