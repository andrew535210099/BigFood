import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import '../UserData/user_provider.dart';

void main() {
  runApp(OrderDetail());
}

class OrderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OrderDetaill(),
    );
  }
}



class OrderItem {
  final String title;
  final int qty;
  final double price;
  final String image;

  OrderItem(this.title, this.qty, this.price, this.image);

  int get burgerQuantity => qty;
}

class OrderListItem extends StatelessWidget {
  final OrderItem item;

  const OrderListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: item.image != null ? Image.network(item.image, fit: BoxFit.cover) : null,
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                "${item.qty}",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          "${item.price * item.qty}",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ],
    );
  }
}


class OrderDetaill extends StatefulWidget {
  @override
  _OrderDetaillState createState() => _OrderDetaillState();
}

class _OrderDetaillState extends State<OrderDetaill> {
  List<OrderItem> orderItems = [];

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  Future<void> fetchCartData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;
    final String? userId = currentUser?.uid;

    CollectionReference cartCollection = FirebaseFirestore.instance.collection('users');
    CollectionReference cartsCollection = FirebaseFirestore.instance.collection('carts');
    DocumentSnapshot documentSnapshot = await cartCollection.doc(userId).get();
    String? userEmail = documentSnapshot['email'] as String?;

    QuerySnapshot snapshot = await cartsCollection.where('email', isEqualTo: userEmail).get();

    for (DocumentSnapshot doc in snapshot.docs) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      if (data != null) {
        int zingerBurgerQuantity = data['zingerBurgerQuantity'] as int;
        int rollParathaQuantity = data['rollParathaQuantity'] as int;
        int burgerQuantity = data['burgerQuantity'] as int;
        int sandwichQuantity = data['sandwichQuantity'] as int;
        int pizzaRollQuantity = data['pizzaRollQuantity'] as int;
        int mushroomSoupQuantity = data['mushroomSoupQuantity'] as int;

        OrderItem orderItem = OrderItem(
          "Zinger Burger",
          zingerBurgerQuantity,
          20000,
          "assets/zingerBurger.png",
        );
        OrderItem orderItem1 = OrderItem(
          "Roll Paratha",
          rollParathaQuantity,
          25000,
          "assets/rollParatha.png",
        );
        OrderItem orderItem2 = OrderItem(
          "Burger",
          burgerQuantity,
          15000,
          "assets/burger.png",
        );
        OrderItem orderItem3 = OrderItem(
          "Sandwich",
          sandwichQuantity,
          20000,
          "assets/sandwich.png",
        );
        OrderItem orderItem4 = OrderItem(
          "Pizza Roll",
          pizzaRollQuantity,
          22000,
          "assets/pizzaRoll.png",
        );
        OrderItem orderItem5 = OrderItem(
          "Mushroom Soup",
          mushroomSoupQuantity,
          10000,
          'assets/mushroomSoup.png',
        );

        setState(() {
          orderItems.add(orderItem);
          orderItems.add(orderItem1);
          orderItems.add(orderItem2);
          orderItems.add(orderItem3);
          orderItems.add(orderItem4);
          orderItems.add(orderItem5);
          

        });
      } else {
        print('Properti tidak ditemukan di dokumen dengan ID ${doc.id}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;
    final String? userId = currentUser?.uid;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Text(
                    "Order Details",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ListView.separated(
  shrinkWrap: true,
  itemCount: orderItems.length,
  itemBuilder: (context, index) {
    return OrderListItem(item: orderItems[index]);
  },
  separatorBuilder: (context, index) {
    return SizedBox(height: 10.0); // Menambahkan jarak vertikal antara item
  },
),

                  const SizedBox(height: 10.0),
                  _buildDivider(),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Ongkir",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Rp ${calculateTotalPrice()}",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Text(
                              "Ongkir",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Rp berapa",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        _buildDivider(),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Rp total",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Container _buildDivider() {
    return Container(
      height: 2.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
  
  double calculateTotalPrice() {
  double totalPrice = 0.0;
  for (var item in orderItems) {
    totalPrice += (item.qty * item.price);
  }
  return totalPrice;
}
}
