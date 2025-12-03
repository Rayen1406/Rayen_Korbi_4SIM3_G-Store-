import 'package:flutter/material.dart';
import 'cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    items = await CartService.getCartItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),

      body: items.isEmpty
          ? const Center(
        child: Text(
          "Cart is empty",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final movie = items[index];

          return ListTile(
            leading: SizedBox(
              width: 60,
              height: 60,
              child: Image.network(
                movie["image"],
                fit: BoxFit.cover,
              ),
            ),
            title: Text(movie["title"]),
            subtitle: Text("${movie["price"]} DT"),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await CartService.removeFromCart(index);
                loadCart();
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete_forever),
        onPressed: () async {
          await CartService.clearCart();
          loadCart();
        },
      ),
    );
  }
}
