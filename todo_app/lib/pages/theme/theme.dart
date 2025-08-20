import 'package:flutter/material.dart';

final ThemeData darkTodoTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212), // Fond sombre
  primaryColor: Colors.blueAccent, // Couleur principale (accent)
  colorScheme: const ColorScheme.dark(
    primary: Colors.blueAccent, // Boutons / éléments principaux
    secondary: Colors.tealAccent, // Couleur secondaire
    surface: Color(0xFF1E1E1E), // Cartes et conteneurs
    onPrimary: Colors.white, // Texte sur les boutons primaires
    onSecondary: Colors.black, // Texte sur éléments secondaires
    onSurface: Colors.white, // Texte général
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1F1F1F),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blueAccent,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  cardTheme: CardThemeData(
    color: const Color(0xFF1E1E1E),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 4,
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: Colors.white70, fontSize: 16),
    bodySmall: TextStyle(color: Colors.white60, fontSize: 14),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(Colors.blueAccent),
    checkColor: MaterialStateProperty.all(Colors.black),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
);
