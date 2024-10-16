import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        primaryColor: Color(0xFF0093B7), // Main blue color from your design
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFF0093B7), // Accent color (also blue)
          background: Color(0xFFF2F2F2), // Light grey background
        ),
        scaffoldBackgroundColor: Color(0xFFF2F2F2), // Match the background color
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0093B7), // Blue background for AppBar
          iconTheme: IconThemeData(color: Colors.white), // Ensure the back button is white
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF0093B7), // Blue button color
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Color(0xFF0093B7), // Button text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFF0093B7), textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}
