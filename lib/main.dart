import 'package:flutter/material.dart';
import 'package:notes/routes.dart';
import 'package:notes/themes.dart';

void main() => runApp(
      const NotesApp(),
    );

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeHelper.lightTheme,
        darkTheme: ThemeHelper.darkTheme,
        themeMode: ThemeMode.system,
        onGenerateRoute: RouteHelper.generateRoutes,
        initialRoute: '/',
      );
}
