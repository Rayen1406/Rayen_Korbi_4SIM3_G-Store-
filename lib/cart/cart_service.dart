import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static const String cartKey = "cart_items";

  // Add movie to cart
  static Future<void> addToCart(Map<String, String> movie) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> cart = prefs.getStringList(cartKey) ?? [];

    cart.add(jsonEncode(movie)); // encode movie map

    await prefs.setStringList(cartKey, cart);
  }

  // Get all cart items
  static Future<List<Map<String, String>>> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(cartKey) ?? [];

    return cart.map((item) {
      return Map<String, String>.from(jsonDecode(item));
    }).toList();
  }

  // Clear cart
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cartKey);
  }

  // Remove a single item from cart by index
  static Future<void> removeFromCart(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(cartKey) ?? [];

    if (index >= 0 && index < cart.length) {
      cart.removeAt(index);
      await prefs.setStringList(cartKey, cart);
    }
  }



}
