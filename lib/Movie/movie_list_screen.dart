import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import '../auth/signin_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';
import 'movie_card.dart';
import 'movie_details_screen.dart';



class MovieListScreen extends StatelessWidget {
  MovieListScreen({super.key});

  final List<Map<String, String>> movies = [
    {
      "title": "Baby Driver",
      "image": "assets/baby_driver.jpg",
      "description":
      "Baby, a young getaway driver, tries to escape the criminal world after one last job.",
      "price": "300",
    },
    {
      "title": "Faster",
      "image": "assets/faster.jpg",
      "description":
      "An ex-convict begins a violent journey to find the people who betrayed him.",
      "price": "250",
    },
    {
      "title": "Tokyo Drift",
      "image": "assets/tokyo_drift.jpg",
      "description":
      "A rebellious teenager discovers the underground world of drift racing in Tokyo.",
      "price": "280",
    },
    {
      "title": "John Wick",
      "image": "assets/john_wick.jpg",
      "description":
      "A retired hitman seeks vengeance against gangsters who wronged him.",
      "price": "320",
    },
    {
      "title": "Mad Max: Fury Road",
      "image": "assets/mad_max.jpg",
      "description":
      "In a wasteland future, Max teams with Furiosa to escape a tyrant.",
      "price": "350",
    },
    {
      "title": "The Dark Knight",
      "image": "assets/dark_knight.jpg",
      "description":
      "Batman faces the Joker, Gotham's most dangerous criminal mastermind.",
      "price": "400",
    },
    {
      "title": "Inception",
      "image": "assets/inception.jpg",
      "description":
      "A thief steals secrets from the subconscious during dream infiltration.",
      "price": "360",
    },
    {
      "title": "Interstellar",
      "image": "assets/interstellar.jpg",
      "description":
      "Explorers travel through a wormhole searching for a new home for humanity.",
      "price": "420",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("G-Store"),

        actions: [
          // PROFILE SCREEN BUTTON
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),

          // LOGOUT BUTTON
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final confirm = await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Logout"),
                  content:
                  const Text("Are you sure you want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await AuthService.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                      (route) => false,
                );
              }
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartScreen()),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: movies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 cards per row
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.60,
        ),
        itemBuilder: (context, index) {
          return MovieCard(
            title: movies[index]["title"]!,
            image: movies[index]["image"]!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      MovieDetailsScreen(movie: movies[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
