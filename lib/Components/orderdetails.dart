import 'package:flutter/material.dart';

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

  // OrderItem({this.title, this.qty, this.price,this.image});
}

class OrderListItem extends StatelessWidget {
  final OrderItem item;

  const OrderListItem(Key? key, this.item):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
              Container(
        width: 100,
        height: 100,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: item.image != null? Image.network(item.image,fit: BoxFit.cover,):null,
      ),
      const SizedBox(width: 20.0,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.title,
                style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            
            ),
            const SizedBox(height: 5.0,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),

              ),
              child: Row(
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(4.0),
                  icon: Icon(Icons.minimize),
                  onPressed: (){

                  },

                  ),
                  Text("${item.qty}",
                //   style: TextStyle(
                // fontSize: 15.0,
                // fontWeight: FontWeight.bold,
                // color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  IconButton(
                  padding: const EdgeInsets.all(4.0),
                  icon: Icon(Icons.add),
                  onPressed: (){
                    
                  },

                  )
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 10.0,),
      Text("${item.price * item.qty}",
                style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              ),

      ],
    );
  }
}


class OrderDetaill extends StatelessWidget {
  const OrderDetaill({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // SizedBox(
          //   height: double.maxFinite,
          //   width: 100,
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Text("Order Detail",
                    style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),),
                const SizedBox(height: 20.0,),
                OrderListItem(key,
                OrderItem("Pizza", 2, 20000, "assets/bg-welcome2.jpg"),

                ),
                const SizedBox(height: 20.0,),
                OrderListItem(key,
                OrderItem("Pizza", 2, 20000, "assets/bg-welcome2.jpg"),

                ),
                const SizedBox(height: 10.0,),
                _buildDivider(),
            
                Row(
                  children: [
                    const SizedBox(width: 40.0,),
                    Text("Ongkir"),
                    Spacer(),
                    Text("Rp berapa"),

                  ],
                ),
                    const SizedBox(height: 10.0,),
                    Row(
                  children: [
                    const SizedBox(width: 40.0,),
                    Text("Ongkir"),
                    Spacer(),
                    Text("Rp berapa"),

                  ],
                ),
                  const SizedBox(height: 20.0,),
                _buildDivider(),
                const SizedBox(height: 10.0,),
                Row(
                  children: [
                    const SizedBox(width: 40.0,),
                    Text("Total",),
                    Spacer(),
                    Text("Rp total"),
                    const SizedBox(width: 20.0,),
                  ],
                ),
                const SizedBox(height: 10.0,),
                
              ],
            ),
          ),
        ],
      )
    );
  
  }
    Container _buildDivider(){
      return Container(
        height: 2.0,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(5.0),
        ),
      );
    }
}

