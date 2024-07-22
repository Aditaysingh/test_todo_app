import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_todo_app/provider/provider_screen.dart';
import 'package:test_todo_app/screens/show_screen.dart';
import 'package:test_todo_app/theme/theme.dart';
import 'package:test_todo_app/provider/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(child: Text("Error loading preferences"));
        }

        SharedPreferences prefs = snapshot.data!;
        bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ThemeProvider()..toggleTheme(isDarkTheme),
            ),
            ChangeNotifierProxyProvider<ThemeProvider, ProviderDB>(
              create: (context) => ProviderDB(context.read<ThemeProvider>()),
              update: (context, themeProvider, providerDB) =>
                  ProviderDB(themeProvider),
            ),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeProvider.isDarkTheme ? darkTheme : lightTheme,
                home: TodoView(),
              );
            },
          ),
        );
      },
    );
  }
}
