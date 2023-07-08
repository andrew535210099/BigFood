import 'package:flutter/material.dart';

void main() {
  runApp(SignUpSuccessPage());
}

class SignUpSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Congrats!',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/congrats.png', // Path to your image asset
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Congrats!',
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(int.parse('FF6440', radix: 16))
                                        .withOpacity(1.0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Your Profile Is Ready To use',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                      primary: Color(int.parse('FF6440', radix: 16)).withOpacity(1.0),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text(
                        'Try Order',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
