import 'package:flutter/material.dart';
import '../models/app_theme.dart';
import '../providers/theme_provider.dart';

/// Widget để hiển thị xem trước theme
class ThemePreview extends StatelessWidget {
  /// Theme để xem trước, nếu null sẽ sử dụng theme hiện tại
  final AppTheme? theme;

  /// Constructor
  const ThemePreview({Key? key, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme previewTheme =
        theme ?? ThemeProvider.of(context).currentTheme;
    final themeData = previewTheme.toThemeData();

    return Theme(
      data: themeData,
      child: Builder(
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: previewTheme.backgroundColor,
              borderRadius: BorderRadius.circular(
                previewTheme.options.borderRadius,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App bar preview
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: previewTheme.primaryColor,
                  child: Row(
                    children: [
                      Icon(
                        Icons.menu,
                        color: _contrastColor(previewTheme.primaryColor),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'App Preview',
                        style: TextStyle(
                          color: _contrastColor(previewTheme.primaryColor),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.search,
                        color: _contrastColor(previewTheme.primaryColor),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.more_vert,
                        color: _contrastColor(previewTheme.primaryColor),
                      ),
                    ],
                  ),
                ),
                // Body preview
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        'Theme Preview',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      // Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Card Example',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'This is how cards will look with this theme.',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('Button'),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text('Outlined'),
                          ),
                          TextButton(onPressed: () {}, child: Text('Text')),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Form field
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Input Field',
                          hintText: 'Enter text...',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Tính toán màu tương phản cho text dựa trên màu nền
  Color _contrastColor(Color background) {
    return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}

/// Widget hiển thị xem trước theme với style Deep Space
class DeepSpaceThemePreview extends StatelessWidget {
  /// Theme để xem trước, nếu null sẽ sử dụng theme hiện tại
  final AppTheme? theme;

  /// Constructor
  const DeepSpaceThemePreview({Key? key, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme previewTheme =
        theme ?? ThemeProvider.of(context).currentTheme;
    final themeData = previewTheme.toThemeData();

    return Theme(
      data: themeData,
      child: Builder(
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: previewTheme.backgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: previewTheme.primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App bar with gradient
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        previewTheme.primaryColor,
                        previewTheme.accentColor ?? previewTheme.primaryColor,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.rocket_launch, color: Colors.white),
                      const SizedBox(width: 12),
                      Text(
                        'Deep Space App',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.search, color: Colors.white),
                      const SizedBox(width: 12),
                      Icon(Icons.more_vert, color: Colors.white),
                    ],
                  ),
                ),
                // Body with space theme
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title with gradient text
                      ShaderMask(
                        shaderCallback:
                            (bounds) => LinearGradient(
                              colors: [
                                previewTheme.primaryColor,
                                previewTheme.accentColor ??
                                    previewTheme.primaryColor,
                              ],
                            ).createShader(bounds),
                        child: Text(
                          'Explore Deep Space',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Card with space theme
                      Card(
                        color: _darken(previewTheme.backgroundColor, 0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            previewTheme.options.borderRadius,
                          ),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.style,
                                    color: previewTheme.primaryColor,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Color Palette',
                                    style: TextStyle(
                                      color: previewTheme.textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _colorSwatch(
                                    color: Color(0xFF0A4235),
                                    label: '#0A4235',
                                  ),
                                  _colorSwatch(
                                    color: Color(0xFF112C71),
                                    label: '#112C71',
                                  ),
                                  _colorSwatch(
                                    color: Color(0xFF56E1E9),
                                    label: '#56E1E9',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _colorSwatch(
                                    color: Color(0xFF5B58EB),
                                    label: '#5B58EB',
                                  ),
                                  _colorSwatch(
                                    color: Color(0xFFBB63FF),
                                    label: '#BB63FF',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Buttons in space theme
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.color_lens),
                            label: Text('Apply'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: previewTheme.primaryColor,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text('Edit'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: previewTheme.primaryColor,
                              side: BorderSide(
                                color: previewTheme.primaryColor,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Reset'),
                            style: TextButton.styleFrom(
                              foregroundColor: previewTheme.textColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Widget hiển thị một mẫu màu
  Widget _colorSwatch({required Color color, required String label}) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 10),
        ),
      ],
    );
  }

  /// Làm tối màu nền
  Color _darken(Color color, double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
