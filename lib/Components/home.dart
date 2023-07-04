import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../UserData/user_provider.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User _user;

  

  void initState(){
    super.initState();
    addToCart();
  }

  int zingerBurgerQuantity = 0;
  int rollParathaQuantity = 0;
  int burgerQuantity = 0 ;
  int sandwichQuantity = 0;
  int pizzaRollQuantity = 0;
  int mushroomSoupQuantity = 0;

  
  void incrementBurger() {
    setState(() {
      burgerQuantity++;
    });
  }

  void decrementBurger() {
    setState(() {
      if (burgerQuantity > 0) {
        burgerQuantity--;
      }
    });
  }

  void incrementSandwich(){
    setState(() {
      sandwichQuantity++;
    });
  }

  void decrementSandwich() {
    setState(() {
      if (sandwichQuantity > 0) {
        sandwichQuantity--;
      }
    });
  }

  void incrementPizzaRoll(){
    setState(() {
      pizzaRollQuantity++;
    });
  }

  void decrementPizzaRoll() {
    setState(() {
      if (pizzaRollQuantity > 0) {
        pizzaRollQuantity--;
      }
    });
  }

  void incrementmushroomSoup(){
    setState(() {
      mushroomSoupQuantity++;
    });
  }

  void decrementmushroomSoup() {
    setState(() {
      if (mushroomSoupQuantity > 0) {
        mushroomSoupQuantity--;
      }
    });
  }

  void incrementZingerBurgerQuantity() {
    setState(() {
      zingerBurgerQuantity++;
    });
  }

  void decrementZingerBurgerQuantity() {
    setState(() {
      if (zingerBurgerQuantity > 0) {
        zingerBurgerQuantity--;
      }
    });
  }

  void incrementRollParathaQuantity() {
    setState(() {
      rollParathaQuantity++;
    });
  }

  void decrementRollParathaQuantity() {
    setState(() {
      if (rollParathaQuantity > 0) {
        rollParathaQuantity--;
      }
    });
  }

  

  void addToCart() async {
  _user = _auth.currentUser!;
  final String userUID = _user.uid;

  try {
    // Mengambil referensi koleksi carts
    CollectionReference cartRef = _firestore.collection('carts');

    // Mengambil dokumen pengguna berdasarkan UID
    DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(userUID).get();
    
    
    if (userSnapshot.exists) {
      final userData = userSnapshot.data() as Map<String, dynamic>;
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      // Mendapatkan email pengguna dari dokumen pengguna
      final userEmail = userProvider.getEmail();

      // Membuat data produk untuk ditambahkan ke cart
      Map<String, dynamic> productData = {
        'userEmail': userEmail,
        'zingerBurgerQuantity': zingerBurgerQuantity,
        'rollParathaQuantity': rollParathaQuantity,
      };

      // Memeriksa apakah ada cart yang terkait dengan email pengguna
      QuerySnapshot existingCart = await cartRef.where('userEmail', isEqualTo: userEmail).get();
      
      if (existingCart.docs.isNotEmpty) {
        // Jika cart sudah ada, perbarui dokumennya
        String cartDocId = existingCart.docs[0].id;
        await cartRef.doc(cartDocId).update(productData);
      } else {
        // Jika cart belum ada, tambahkan dokumen baru
        await cartRef.add(productData);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added to cart.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User document not found.')),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error occurred: $error')),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homepage',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 150.0,
              bottom: PreferredSize(                       // Add this code
                preferredSize: Size.fromHeight(30.0),      // Add this code
                child: Text(''),                           // Add this code
            ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Find Your\nFavorite Food',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Popular Menu',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid.count(
                childAspectRatio: (1 / 1.4),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  // Zinger Burger
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: const Color.fromARGB(255, 255, 238, 218),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/zingerBurger.png',
                          fit: BoxFit.contain,
                        ),
                        Text(
                          "Zinger Burger",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Text(
                          "Rp 20.000",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 100, 64),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: decrementZingerBurgerQuantity,
                            ),
                            Text(
                              zingerBurgerQuantity.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: incrementZingerBurgerQuantity,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  // Roll Paratha
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: const Color.fromARGB(255, 255, 238, 218),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/rollParatha.png',
                          fit: BoxFit.contain,
                        ),
                        Text(
                          "Roll Paratha",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Text(
                          "Rp 25.000",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 100, 64),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: decrementRollParathaQuantity,
                            ),
                            Text(
                              rollParathaQuantity.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: incrementRollParathaQuantity,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
        Container(
            padding: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 255, 238, 218),
            child: Column(children: [
                  Image.asset(
                    height:120,
                          width: 120,
                    'assets/burger.png',
                    fit: BoxFit.contain,
                  ),
              Text("Burger",
              style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
              ),
                            Text("Rp 15.000",
              style:TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 100, 64),
                    ),
              ),
Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: decrementBurger,
                            ),
                            Text(
                              burgerQuantity.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: incrementBurger,
                            ),
                          ],
                        ),
            ],),
          ),
        // Sandwich
        Container(
            padding: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 255, 238, 218),
            child: Column(children: [
                  Image.asset(
                    height:120,
                          width: 120,
                    'assets/sandwich.png',
                    fit: BoxFit.contain,
                  ),
              Text("Sandwich",
              style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
              ),
                            Text("Rp 20.000",
              style:TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 100, 64),
                    ),
              ),
Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: decrementSandwich,
                            ),
                            Text(
                              sandwichQuantity.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: incrementSandwich,
                            ),
                          ],
                        ),
            ],),
          ),

        Container(
            padding: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 255, 238, 218),
            child: Column(children: [
                  Image.asset(
                    height:120,
                          width: 120,
                    'assets/pizzaRoll.png',
                    fit: BoxFit.contain,
                  ),
              Text("Pizza Roll",
              style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
              ),
                            Text("Rp 22.000",
              style:TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 100, 64),
                    ),
              ),
              Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: decrementPizzaRoll,
                            ),
                            Text(
                              pizzaRollQuantity.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: incrementPizzaRoll,
                            ),
                          ],
                        ),
            ],),
          ),

        Container(
            padding: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 255, 238, 218),
            child: Column(children: [
                  Image.asset(
                    height:120,
                          width: 120,
                    'assets/mushroomSoup.png',
                    fit: BoxFit.contain,
                  ),
              Text("Mushroom Soup",
              style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
              ),
                            Text("Rp 17.000",
              style:TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 100, 64),
                    ),
              ),
              Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: decrementmushroomSoup,
                            ),
                            Text(
                              mushroomSoupQuantity.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: incrementmushroomSoup,
                            ),
                          ],
                        ),
            ],),
          ),
        ],
      ),
    ),

SliverPadding(
      padding: const EdgeInsets.all(20),
      
      sliver: SliverList(
                  delegate: SliverChildListDelegate([
                  
                    Text(
                      'Popular Menu',
                      style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
              ),
                    ),
                  ]),
                ),
    ),
  SliverPadding(
      padding: const EdgeInsets.all(20),
      
      sliver: SliverGrid.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: (1 / 1.4),
        children: <Widget>[
          // Zinger Burger
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 255, 238, 218),
            child: Column(children: [
                  Image.asset(
                    height:120,
                          width: 120,
                    'assets/zingerBurger.png',
                    fit: BoxFit.contain,
                  ),
              Text("Zinger Burger",
              style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
              ),
                            Text("Rp 20.000",
              style:TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 100, 64),
                    ),
              ),

            ],),
          ),
          // Roll Paratha
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 255, 238, 218),
            child: Column(children: [
                  Image.asset(
                    height:120,
                          width: 120,
                    'assets/rollParatha.png',
                    fit: BoxFit.contain,
                  ),
              Text("Roll Paratha",
              style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
              ),
                            Text("Rp 25.000",
              style:TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 100, 64),
                    ),
              ),

            ],),
          ),
        Container(
            padding: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 255, 238, 218),
            child: Column(children: [
                  Image.asset(
                    height:120,
                          width: 120,
                    'assets/burger.png',
                    fit: BoxFit.contain,
                  ),
              Text("Burger",
              style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
              ),
                            Text("Rp 15.000",
              style:TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 100, 64),
                    ),
              ),

            ],),
          ),
        // Sandwich
        Container(
            padding: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 255, 238, 218),
            child: Column(children: [
                  Image.asset(
                    height:120,
                          width: 120,
                    'assets/sandwich.png',
                    fit: BoxFit.contain,
                  ),
              Text("Sandwich",
              style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
              ),
                            Text("Rp 20.000",
              style:TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 100, 64),
                    ),
              ),

            ],),
          ),

        Container(
            padding: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 255, 238, 218),
            child: Column(children: [
                  Image.asset(
                    height:120,
                          width: 120,
                    'assets/pizzaRoll.png',
                    fit: BoxFit.contain,
                  ),
              Text("Pizza Roll",
              style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
              ),
                            Text("Rp 22.000",
              style:TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 100, 64),
                    ),
              ),

            ],),
          ),

        Container(
            padding: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 255, 238, 218),
            child: Column(children: [
                  Image.asset(
                    height:120,
                          width: 120,
                    'assets/mushroomSoup.png',
                    fit: BoxFit.contain,
                  ),
              Text("Mushroom Soup",
              style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
              ),
                            Text("Rp 17.000",
              style:TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 100, 64),
                    ),
              ),

            ],),
          ),
        ],
      ),
    ),

  ],
),
    ),
    
    );
  }
}
