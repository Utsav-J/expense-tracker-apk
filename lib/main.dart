import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/services.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.white);
var kDarkColorScheme =
    ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: Colors.black);
void main() {
  // NOTE THAT THE RUNAPP IS INSIDE THE THEN FUNCTIONS PARAMETERS
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((func) {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          elevation: 3,
          shadowColor: Colors.black,
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          surfaceTintColor: Colors.white,
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(
                color: Colors.black,
                fontFamily: 'GamePlay',
                fontSize: 20,
              ),
              displayMedium: const TextStyle(
                color: Colors.black,
                fontFamily: 'GameOver',
                fontSize: 20,
              ),
            ),
      ),
      themeMode: ThemeMode.light,
      home: const Expenses(),
    ),
  );
}
//   );
// }
