import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';

class ThemeSettingsPage extends StatefulWidget {
  const ThemeSettingsPage({super.key});

  @override
  State<ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  late AppTheme editingTheme;

  @override
  void initState() {
    super.initState();
    editingTheme = ThemeProvider.of(context, listen: false).currentTheme;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              themeProvider.addTheme(editingTheme);
              themeProvider.setTheme(editingTheme.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview of current theme
            Text('Preview', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),

            // Show appropriate preview based on theme type
            editingTheme.id.contains('deep_space')
                ? DeepSpaceThemePreview(theme: editingTheme)
                : ThemePreview(theme: editingTheme),

            const SizedBox(height: 32),

            // Theme type selection
            Text('Theme Type', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('Light'),
                  icon: Icon(Icons.wb_sunny),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.nights_stay),
                ),
              ],
              selected: {editingTheme.themeMode},
              onSelectionChanged: (Set<ThemeMode> modes) {
                setState(() {
                  editingTheme = editingTheme.copyWith(themeMode: modes.first);
                });
              },
            ),

            const SizedBox(height: 24),

            // Theme name
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Theme Name',
                hintText: 'Enter a name for this theme',
              ),
              initialValue: editingTheme.name,
              onChanged: (value) {
                setState(() {
                  editingTheme = editingTheme.copyWith(name: value);
                });
              },
            ),

            const SizedBox(height: 24),

            // Color settings
            Text('Colors', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),

            // Deep Space color palette display
            if (editingTheme.id.contains('deep_space'))
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deep Space Palette',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _colorDisplay(
                            context,
                            'Dark Cyan',
                            const Color(0xFF0A4235),
                          ),
                          _colorDisplay(
                            context,
                            'Deep Blue',
                            const Color(0xFF112C71),
                          ),
                          _colorDisplay(
                            context,
                            'Cyan',
                            const Color(0xFF56E1E9),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _colorDisplay(
                            context,
                            'Periwinkle',
                            const Color(0xFF5B58EB),
                          ),
                          _colorDisplay(
                            context,
                            'Lavender',
                            const Color(0xFFBB63FF),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Advanced options note
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Deep Space Themes',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Deep Space themes use carefully crafted color palettes for a cohesive look. For advanced customization, create a copy of the theme first.',
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Show color picker dialog or navigate to custom color screen
                        },
                        child: const Text('Advanced Options'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorDisplay(BuildContext context, String name, Color color) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.surface,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        Text(
          // ignore: deprecated_member_use
          '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontFamily: 'monospace',
            fontSize: 10,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
