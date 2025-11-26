import 'package:flutter/material.dart';
import 'auth/signin_screen.dart';
import 'Movie/movie_list_screen.dart';
import 'auth/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GStoreApp());
}

class GStoreApp extends StatelessWidget {
  const GStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthService.isLoggedIn(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(home: SizedBox());
        }

        final loggedIn = snapshot.data!;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'G-Store',

          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,

          home: loggedIn ? MovieListScreen() : const SignInScreen(),
        );
      },
    );
  }
}
