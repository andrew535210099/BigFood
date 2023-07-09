import 'package:flutter/material.dart';
  

  
class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Transform.translate(
          offset: Offset(0, 5), // Menyesuaikan offset secara vertikal
          child: Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'You can change the payment method\nin each order',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 40.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  PaymentOptionTile(
                    icon: Icons.attach_money,
                    title: 'Cash', onTap: () { Navigator.pushNamed(
                          context,
                          '/homebar',
                          arguments: {'currentIndex': 3}, // Pindah ke tab ke-2 (indeks 1)
                        ); },
                  ),
                  PaymentOptionTile(
                    icon: Icons.credit_card,
                    title: 'Card', onTap: () { Navigator.pushNamed(
                          context,
                          '/homebar',
                          arguments: {'currentIndex': 3}, // Pindah ke tab ke-2 (indeks 1)
                        ); },
                  ),
                  PaymentOptionTile(
                    icon: Icons.business,
                    title: 'Third Party', onTap: () { Navigator.pushNamed(
                          context,
                          '/homebar',
                          arguments: {'currentIndex': 3}, // Pindah ke tab ke-2 (indeks 1)
                        ); },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
               Navigator.pushNamed(
                          context,
                          '/homebar',
                         // Pindah ke tab ke-2 (indeks 1)
                        );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(int.parse('FF6440', radix: 16)).withOpacity(1.0),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                'Confirm Changes',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class PaymentOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const PaymentOptionTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(1.0),
      ),
      child: Material(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            padding:
                EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
            child: Row(
              children: [
                Icon(icon),
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18.0),
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
