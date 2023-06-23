import 'package:expense_tracker/expense_screen.dart';
import 'package:flutter/material.dart';
// need to extend this for locking orientation
//import 'package:flutter/services.dart';

// to disable the landscape mode

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 93, 61, 145));
var kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0));
void main() {
  // this makes sure that locking the orientation and then running the app works finely
//   WidgetsFlutterBinding.ensureInitialized();
//   // this is useful in locking device orientation
//   SystemChrome.setPreferredOrientations([
//     // this keeps the orientation same as up always . then is written because i is ann async method therefore this works fine
//     DeviceOrientation.portraitUp
//   ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme()
            .copyWith(color: kDarkColorScheme.tertiaryContainer),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.secondaryContainer),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        cardTheme:
            const CardTheme().copyWith(color: kColorScheme.tertiaryContainer),
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.secondaryContainer),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      themeMode: ThemeMode.system,
      home: const ExpenseScreen(),
    );
  }
}

/*Row(
                children: [
                  const Text('Select date'),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.alarm_add))
                ],
              )
            ]),
          ),
          Row(children: [
            ElevatedButton(onPressed: () {}, child: const Text('Save')),
            const SizedBox(
              width: 8,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Cancel'))
          ]),*/
