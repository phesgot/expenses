import 'package:expenses/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const Expenses());

class Expenses extends StatelessWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: const Color(0xff581845),
          secondary: Colors.black,
          tertiary: Colors.grey[200],
        ),
        textTheme: GoogleFonts.quicksandTextTheme(textTheme).copyWith(
          bodySmall: GoogleFonts.quicksand(
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          //bodyMedium font default
          bodyMedium: GoogleFonts.quicksand(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          bodyLarge: GoogleFonts.quicksand(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff581845),
              ),
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.openSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
