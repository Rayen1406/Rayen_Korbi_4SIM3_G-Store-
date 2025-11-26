import 'package:flutter/material.dart';
import 'cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, String>> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    final items = await CartService.getCart();
    setState(() {
      cartItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),

      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (_, index) {
          final movie = cartItems[index];

          return ListTile(
            leading: Image.asset(movie["image"]!, width: 50),
            title: Text(movie["title"]!),
            subtitle: Text("${movie['price']} DT"),

            // DELETE SINGLE MOVIE BUTTON
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await CartService.removeFromCart(index);
                await loadCart(); // refresh UI
              },
            ),
          );
        },
      ),


      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await CartService.clearCart();
          await loadCart();
        },
        icon: const Icon(Icons.delete),
        label: const Text("Clear Cart"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
