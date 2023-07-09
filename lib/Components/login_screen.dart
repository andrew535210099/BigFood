import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duds/UserData/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/widgets.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var db = FirebaseFirestore.instance;
  bool _showPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login(BuildContext context) async {
  final email = _emailController.text;
  final password = hashPassword(_passwordController.text);
  final password1 = _passwordController.text;

  if (email.isEmpty || password.isEmpty || password1.isEmpty) {
    print('Please fill in all fields');
    return;
  }

  try {
    final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user != null) {
      final user = _auth.currentUser;
      final email = user?.email;

      if (email != null) {
        final userSnapshot =
            await db.collection('users').doc(user!.uid).get();
        final username = userSnapshot.get('username');
        final email = userSnapshot.get('email');

        // Set the username in the userProvider
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUsername(username);
        userProvider.setEmail(email);
        // Proceed with navigation
        Navigator.pushReplacementNamed(context, '/homebar');
        print('User $username logged in at ${DateTime.now()}');
        print('Login successful');
      }
    }
  } catch (error) {
    try{
    final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password1,
    );

    if (userCredential.user != null) {
      final user = _auth.currentUser;
      final email = user?.email;

      if (email != null) {
        final userSnapshot =
            await db.collection('users').doc(user!.uid).get();
        final username = userSnapshot.get('username');
        final email = userSnapshot.get('email');
        final photo = userSnapshot.get('photoURL');

        // Set the username in the userProvider
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUsername(username);
        userProvider.setEmail(email);
        // Proceed with navigation
        Navigator.pushReplacementNamed(context, '/homebar');
        print('User $username logged in at ${DateTime.now()}');
        print('Login successful');
      }
    }
    // Handle error
    }catch(error){
       WidgetsBinding.instance.addPostFrameCallback((_) {
    Fluttertoast.showToast(
      msg: 'Error logging in: $error',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Color(int.parse('FF6440', radix: 16)).withOpacity(1.0),
      textColor: Colors.white,
    );
  });
    }
  }
}


String hashPassword(String password) {
  final bytes = utf8.encode(password); // Konversi password ke bytes
  final hash = sha256.convert(bytes); // Lakukan hashing menggunakan SHA-256
  return hash.toString();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/BigFood.png',
                    width: 40.0,
                    height: 40.0,
                  ),
                  Text(
                    'BigFood',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Deliver Favourite Food',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  CardBox(
                    child: Container(
                      width: 300.0, // Ubah lebar CardBox sesuai kebutuhan
                      child: Column(
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 25.0),
                          BoxWrapper(
                            child: BoxTextField(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              controller: _emailController,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          BoxWrapper(
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                BoxTextField(
                                  hintText: 'Password',
                                  obscureText: !_showPassword,
                                  prefixIcon: Icon(Icons.lock),
                                  controller: _passwordController,
                                ),
                                IconButton(
                                  icon: Icon(
                                    _showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/resetpass');
                              },
                              child: Text(
                                'Forget Password?',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                            onPressed: () {
                              login(context);
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(int.parse('FF6440', radix: 16))
                                    .withOpacity(1.0),
                                minimumSize: Size(double.infinity, 48.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'or',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage('assets/facebookicon.png'),
                              ),
                              SizedBox(width: 10.0),
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage('assets/googleicon.jpg'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Column(
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 10.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(int.parse('FF6440', radix: 16))
                                .withOpacity(1.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardBox extends StatelessWidget {
  final Widget child;

  const CardBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}

class BoxWrapper extends StatelessWidget {
  final Widget child;

  const BoxWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}

class BoxTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Icon? prefixIcon;
  final TextEditingController? controller;

  const BoxTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.prefixIcon,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        prefixIcon: prefixIcon,
      ),
      obscureText: obscureText,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}
