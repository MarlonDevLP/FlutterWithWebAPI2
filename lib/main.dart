import 'package:appdiariooo/screens/add_journal_screen/add_journal_screen.dart';
import 'package:appdiariooo/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/journal.dart';
import 'screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Journal',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
          actionsIconTheme: IconThemeData(color: Colors.green),
          iconTheme: IconThemeData(color: Colors.green),
        ),
        textTheme: GoogleFonts.bitterTextTheme(),
      ),
      initialRoute: "login",
      routes: {
        "home": (context) => const HomeScreen(),
        "login": (context) => LoginScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "add-journal") {
          final map = settings.arguments as Map<String, dynamic>;
          final Journal journal = map["journal"] as Journal;
          final bool isEditing = map["is_editing"];
          return MaterialPageRoute(
            builder: (context) {
              return AddJournalScreen(journal: journal, isEditing: isEditing,);
            },
          );
        }
        return null;
      },
    );
  }
}
