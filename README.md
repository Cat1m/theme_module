# Theme Module

A simple Flutter package for managing application themes with multiple options and easy integration, including the beautiful Deep Space theme set and custom color palettes.

## Features

- 🎨 Manage multiple themes (light, dark, and custom)
- 🌈 Automatically save and restore selected themes
- 🎭 Easily switch between themes
- 🧩 Simple and intuitive API
- 🚀 Beautiful Deep Space theme set with blue-to-purple gradients
- 🔮 Custom Deep Purple (#4d2962) theme implementation
- 🛠️ Theme customization utilities
- 📱 Theme display and selection widgets

## Installation

Add `theme_module` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  theme_module:
    git:
      url: https://github.com/yourusername/theme_module.git
```

## Basic Usage

### Initialize the theme module

```dart
import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the theme module with default themes
  await ThemeModule.initialize(
    themes: ThemeUtils.createDefaultThemes(),
    defaultThemeId: 'light',
    useMaterial3: true,
  );
  
  runApp(const MyApp());
}
```

### Use ThemeProvider

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider.create(
      child: Builder(
        builder: (context) {
          final themeProvider = ThemeProvider.of(context);
          
          return MaterialApp(
            title: 'My App',
            theme: themeProvider.themeData,
            themeMode: themeProvider.themeMode,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
```

## Using Deep Space Themes

### Initialize with Deep Space theme set

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Get Deep Space themes
  final deepSpaceThemes = ThemeUtils.createDeepSpaceThemes();
  
  // Initialize module with Deep Space themes
  await ThemeModule.initialize(
    themes: [...ThemeUtils.createDefaultThemes(), ...deepSpaceThemes],
    defaultThemeId: 'deep_space_blue', // Use Deep Space as default theme
    useMaterial3: true,
  );
  
  runApp(const MyApp());
}
```

### Display Deep Space theme picker

```dart
class ThemePickerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Theme')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deep Space theme picker
            DeepSpaceThemePicker(
              onThemeSelected: (theme) {
                // Handle when theme is selected
                print('Selected theme: ${theme.name}');
              },
            ),
            
            SizedBox(height: 16),
            
            // Display theme preview
            DeepSpaceThemePreview(),
          ],
        ),
      ),
    );
  }
}
```

## Using Custom Color Themes

### Using Deep Purple (#4d2962) Theme

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Get different theme sets
  final defaultThemes = ThemeUtils.createDefaultThemes();
  final deepSpaceThemes = ThemeUtils.createDeepSpaceThemes();
  final purpleThemes = PurpleThemeCreator.createPurpleThemes();
  
  // Initialize with all themes
  await ThemeModule.initialize(
    themes: [
      ...defaultThemes, 
      ...deepSpaceThemes,
      ...purpleThemes,
    ],
    defaultThemeId: 'purple_light', // Use Purple Light as default
    useMaterial3: true,
  );
  
  runApp(const MyApp());
}
```

### Creating Custom Color Themes

```dart
// Create a theme creator for your custom color
class CustomThemeCreator {
  // Define your main color
  static const Color customColor = Color(0xFFYOURCOLOR);
  
  // Create themes based on your color
  static List<AppTheme> createCustomThemes({String? fontFamily}) {
    return [
      // Light theme
      AppTheme(
        id: 'custom_light',
        name: 'Custom Light',
        themeMode: ThemeMode.light,
        primaryColor: customColor,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
        fontFamily: fontFamily,
        options: ThemeOptions(
          borderRadius: 8.0,
          cardElevation: 1.0,
        ),
      ),
      
      // Dark theme
      AppTheme(
        id: 'custom_dark',
        name: 'Custom Dark',
        themeMode: ThemeMode.dark,
        primaryColor: customColor,
        backgroundColor: Color(0xFF121212),
        textColor: Colors.white,
        fontFamily: fontFamily,
        options: ThemeOptions(
          borderRadius: 8.0,
          cardElevation: 1.0,
        ),
      ),
    ];
  }
}
```

## Customizing Themes

### Create a new theme

```dart
// Create a custom theme
final myCustomTheme = AppTheme(
  id: 'custom_theme',
  name: 'My Theme',
  description: 'My custom theme',
  themeMode: ThemeMode.light,
  primaryColor: Colors.purple,
  accentColor: Colors.amber,
  backgroundColor: Colors.white,
  textColor: Colors.black87,
  fontFamily: 'Roboto',
  options: ThemeOptions(
    borderRadius: 10.0,
    cardElevation: 2.0,
  ),
);

// Add theme to the list
ThemeProvider.instance.addTheme(myCustomTheme);

// Apply theme
ThemeProvider.instance.setTheme('custom_theme');
```

### Create a theme from Deep Space

```dart
// Create custom Deep Space theme
final deepSpaceCustom = ThemeUtils.createDeepSpaceTheme(
  id: 'my_deep_space',
  name: 'Deep Space Custom',
);

// Add to provider
ThemeProvider.instance.addTheme(deepSpaceCustom);
```

## Using PANTONE Colors

The package includes utilities to work with PANTONE colors, such as PANTONE® P 94-16 C or any other brand color:

```dart
// Define your PANTONE color (e.g., Deep Purple #4d2962)
final pantonePurple = Color(0xFF4d2962);

// Create themes with this color
final pantoneThemes = PurpleThemeCreator.createPurpleThemes();

// Add to your app
ThemeProvider.instance.addTheme(pantoneThemes.first);
```

## Real-world Examples

### Media viewer app with Deep Space theme

```dart
class MediaViewerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Deep Space Media'),
        actions: [
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => DeepSpaceThemePicker(),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                themeProvider.currentTheme.options.borderRadius,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // Image or media
                Container(
                  color: themeProvider.currentTheme.primaryColor.withValues(alpha: 0.3),
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 48,
                      color: themeProvider.currentTheme.primaryColor,
                    ),
                  ),
                ),
                // Title bar
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                    child: Text(
                      'Media ${index + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: themeProvider.currentTheme.primaryColor,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
```

## License

This package is distributed under the MIT license.

---

Created with ❤️ by [Your Name]