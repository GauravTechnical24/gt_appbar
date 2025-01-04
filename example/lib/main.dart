import 'package:flutter/material.dart';
import 'package:gt_appbar/gt_appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AppBarExample(),
    );
  }
}

class AppBarExample extends StatefulWidget {
  const AppBarExample({super.key});

  @override
  State<AppBarExample> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AppBarExample> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  GTAppBar(
            title: "Global AppBar",
            backgroundColor: Colors.white,
            showDivider: true,
            bottomCurveness: 8.0,
            elevation: 8.0,
            centerTitle: false,
            titleSpacing: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Handle menu press
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Handle search press
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Handle notifications press
                },
                
              ),
              
            ],
          ),
    );
  }
}
