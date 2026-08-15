import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/auth_wrapper.dart';
import 'screens/student_home_hub.dart' as student_home_hub;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NextGenLMSApp());
}

class NextGenLMSApp extends StatelessWidget {
  const NextGenLMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Next Gen LMS',
      debugShowCheckedModeBanner: false,

      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.trackpad,
        },
      ),

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        primaryColor: const Color(0xFFEA580C),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF10B981),
          primary: const Color(0xFFEA580C),
          secondary: const Color(0xFF10B981),
          surface: Colors.white,
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.light().textTheme,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFFEA580C),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color(0xFF10B981),
          primary: const Color(0xFFEA580C),
          secondary: const Color(0xFF10B981),
          surface: const Color(0xFF1E293B),
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),

      themeMode: ThemeMode.light,

      home: const AuthWrapper(),

      routes: {
        '/auth': (context) => const AuthWrapper(),

        '/student-dashboard': (context) =>
            const student_home_hub.StudentHomeHubScreen(
              userName: 'Student',
            ),
      },
    );
  }
}