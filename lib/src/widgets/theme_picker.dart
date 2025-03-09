import 'package:flutter/material.dart';
import '../models/app_theme.dart';
import '../providers/theme_provider.dart';
import '../utils/theme_utils.dart';

/// Widget để hiển thị và chọn theme
class ThemePicker extends StatelessWidget {
  /// Callback khi theme được chọn
  final Function(AppTheme)? onThemeSelected;

  /// Constructor
  const ThemePicker({Key? key, this.onThemeSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final currentTheme = themeProvider.currentTheme;
    final themes = themeProvider.themes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Chọn Theme',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: themes.length,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemBuilder: (context, index) {
              final theme = themes[index];
              final isSelected = theme.id == currentTheme.id;

              return ThemeOptionCard(
                theme: theme,
                isSelected: isSelected,
                onTap: () {
                  themeProvider.setTheme(theme.id);
                  if (onThemeSelected != null) {
                    onThemeSelected!(theme);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Card hiển thị một lựa chọn theme
class ThemeOptionCard extends StatelessWidget {
  final AppTheme theme;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemeOptionCard({
    Key? key,
    required this.theme,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = theme.options.borderRadius;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: theme.backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: isSelected ? theme.primaryColor : theme.backgroundColor,
              width: 2,
            ),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: theme.primaryColor.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ]
                    : null,
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Preview circle with theme's primary color
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _contrastColor(theme.primaryColor),
                    width: 1,
                  ),
                ),
                child:
                    isSelected
                        ? Icon(
                          Icons.check,
                          color: _contrastColor(theme.primaryColor),
                          size: 24,
                        )
                        : null,
              ),
              const SizedBox(height: 8),
              // Theme name
              Text(
                theme.name,
                style: TextStyle(
                  color: theme.textColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Tính toán màu tương phản cho text dựa trên màu nền
  Color _contrastColor(Color background) {
    return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}

/// Widget hiển thị theme theo dạng gradient Deep Space
class DeepSpaceThemePicker extends StatelessWidget {
  /// Callback khi theme được chọn
  final Function(AppTheme)? onThemeSelected;

  /// Constructor
  const DeepSpaceThemePicker({Key? key, this.onThemeSelected})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lấy danh sách theme Deep Space
    final deepSpaceThemes = ThemeUtils.createDeepSpaceThemes();
    final themeProvider = ThemeProvider.of(context);
    final currentThemeId = themeProvider.currentTheme.id;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF0A4235), // Dark cyan
            Color(0xFF112C71), // Deep blue
            Color(0xFF5B58EB), // Periwinkle
            Color(0xFFBB63FF), // Lavender
          ],
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.color_lens, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                'Deep Space Themes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: deepSpaceThemes.length,
              itemBuilder: (context, index) {
                final theme = deepSpaceThemes[index];
                final isSelected = theme.id == currentThemeId;

                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: InkWell(
                    onTap: () {
                      // Thêm theme vào provider nếu chưa có
                      themeProvider.addTheme(theme);
                      // Đặt theme làm theme hiện tại
                      themeProvider.setTheme(theme.id);
                      if (onThemeSelected != null) {
                        onThemeSelected!(theme);
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: theme.backgroundColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.white30,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow:
                            isSelected
                                ? [
                                  BoxShadow(
                                    color: theme.primaryColor.withOpacity(0.5),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ]
                                : null,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  theme.primaryColor,
                                  theme.accentColor ?? theme.primaryColor,
                                ],
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white30),
                            ),
                            child:
                                isSelected
                                    ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 24,
                                    )
                                    : null,
                          ),
                          SizedBox(height: 8),
                          Text(
                            theme.name.replaceAll('Deep Space ', ''),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
