import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {

  final ScrollController scrollController;

  OrderScreen({required this.scrollController});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart,
              size: 100, color: Color.fromARGB(153, 195, 195, 195)),
          Center(child: Text("Order Please!")),
        ],
      ),
    );
  }
}
