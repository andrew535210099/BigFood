import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Track Order',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 255, 132, 18),
      ),
      home: TrackOrderPage(),
    );
  }
}

class TrackOrderPage extends StatefulWidget {
  @override
  _TrackOrderPageState createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  String currentStatus = 'Picking Up';

  List<String> orderStatus = [
    'Picking Up',
    'On the Way',
    'Delivered',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Order'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current Status:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              currentStatus,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 40),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: orderStatus.map((status) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentStatus = status;
                    });
                  },
                  child: Text(status),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
