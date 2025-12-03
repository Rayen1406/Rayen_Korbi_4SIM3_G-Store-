import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static const String cartKey = "cart_items";

  // ---------------------------------------------------
  // ADD MOVIE TO CART
  // ---------------------------------------------------
  static Future<void> addToCart(Map<String, dynamic> movie) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> cart = prefs.getStringList(cartKey) ?? [];

    // Convert dynamic map to JSON string
    cart.add(jsonEncode(movie));

    await prefs.setStringList(cartKey, cart);
  }

  // ---------------------------------------------------
  // GET ALL MOVIES FROM CART
  // ---------------------------------------------------
  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(cartKey) ?? [];

    return cart.map((item) {
      return Map<String, dynamic>.from(jsonDecode(item));
    }).toList();
  }

  // ---------------------------------------------------
  // REMOVE A SINGLE ITEM BY INDEX
  // ---------------------------------------------------
  static Future<void> removeFromCart(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(cartKey) ?? [];

    if (index >= 0 && index < cart.length) {
      cart.removeAt(index);
      await prefs.setStringList(cartKey, cart);
    }
  }

  // ---------------------------------------------------
  // CLEAR ALL CART ITEMS
  // ---------------------------------------------------
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cartKey);
  }

  // ---------------------------------------------------
  // CHECK CART SIZE
  // ---------------------------------------------------
  static Future<int> cartCount() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(cartKey) ?? []).length;
  }

  // ---------------------------------------------------
  // GET TOTAL PRICE
  // ---------------------------------------------------
  static Future<double> getTotalPrice() async {
    List<Map<String, dynamic>> items = await getCartItems();

    double total = 0;

    for (var item in items) {
      if (item["price"] != null) {
        total += double.tryParse(item["price"].toString()) ?? 0;
      }
    }

    return total;
  }
}
