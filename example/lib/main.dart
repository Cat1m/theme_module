import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';
import 'screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo theme module với các theme Purple
  final purpleThemes = PurpleThemeCreator.createPurpleThemes();

  // Khởi tạo ThemeModule với các theme Purple
  await ThemeModule.initialize(
    themes: purpleThemes,
    defaultThemeId: 'purple_light',
    useMaterial3: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap app với ThemeProvider
    return ThemeProvider.create(
      child: Builder(
        builder: (context) {
          final themeProvider = ThemeProvider.of(context);

          return MaterialApp(
            title: 'Theme Module Example',
            theme: themeProvider.themeData,
            themeMode: themeProvider.themeMode,
            home: const HomePage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
