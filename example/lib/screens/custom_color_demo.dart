import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';
import '../themes/purple_theme.dart';

class CustomColorDemo extends StatelessWidget {
  const CustomColorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final isPurpleTheme = themeProvider.currentTheme.id.contains('purple');

    return Scaffold(
      appBar: AppBar(title: const Text('Custom Color Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color Info Card
            _buildColorInfoCard(context),

            const SizedBox(height: 24),

            // Theme Selector
            Text(
              'Purple Themes',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            // Purple theme selector
            _buildPurpleThemeSelector(context),

            const SizedBox(height: 24),

            // Color Palette
            Text(
              'Color Palette',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            _buildColorPalette(context),

            const SizedBox(height: 24),

            // UI Examples with current theme
            Text(
              'UI Examples',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            // Card Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Purple Theme Demo',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This card demonstrates how the Deep Purple theme (#4d2962) is applied to various UI components.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('CANCEL'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('APPLY'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Form fields with theme
            TextField(
              decoration: InputDecoration(
                labelText: 'Input Field',
                hintText: 'Enter text here',
                prefixIcon: const Icon(Icons.edit),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    themeProvider.currentTheme.options.borderRadius,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Buttons example
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('ELEVATED')),
                OutlinedButton(onPressed: () {}, child: const Text('OUTLINED')),
                TextButton(onPressed: () {}, child: const Text('TEXT')),
              ],
            ),

            const SizedBox(height: 24),

            // Gradient example
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: PurpleThemeCreator.createPurpleGradient(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Purple Gradient',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.color_lens),
      ),
    );
  }

  Widget _buildColorInfoCard(BuildContext context) {
    final colorInfo = PurpleThemeCreator.getColorInfo();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: PurpleThemeCreator.purpleColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deep Purple',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        colorInfo['hex'] ?? '#4d2962',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            _buildColorProperty(context, 'RGB', colorInfo['rgb'] ?? ''),
            _buildColorProperty(context, 'HSL', colorInfo['hsl'] ?? ''),
            _buildColorProperty(context, 'RGBA', colorInfo['rgba'] ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _buildColorProperty(BuildContext context, String name, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurpleThemeSelector(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final purpleThemes = PurpleThemeCreator.createPurpleThemes();

    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(12),
        itemCount: purpleThemes.length,
        itemBuilder: (context, index) {
          final theme = purpleThemes[index];
          final isSelected = themeProvider.currentTheme.id == theme.id;

          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: InkWell(
              onTap: () {
                // Thêm theme vào provider nếu chưa có
                themeProvider.addTheme(theme);
                // Đặt làm theme hiện tại
                themeProvider.setTheme(theme.id);
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? theme.primaryColor : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow:
                      isSelected
                          ? [
                            BoxShadow(
                              color: theme.primaryColor.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ]
                          : null,
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.textColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child:
                          isSelected
                              ? Icon(
                                Icons.check,
                                color: theme.textColor,
                                size: 24,
                              )
                              : null,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      theme.name,
                      style: TextStyle(
                        color: theme.textColor,
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildColorPalette(BuildContext context) {
    final colors = PurpleThemeCreator.getComplementaryColors();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Purple Color Palette',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(colors.length, (index) {
                return _buildColorCircle(colors[index], index);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorCircle(Color color, int index) {
    // Tạo danh sách tên màu
    const List<String> colorNames = [
      'Primary',
      'Light',
      'Dark',
      'Lavender',
      'Violet',
    ];

    // Tạo danh sách hex code
    final List<String> hexCodes = [
      '#4d2962',
      '#7A5095',
      '#2E1A3B',
      '#AF8FC8',
      '#8247A4',
    ];

    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(colorNames[index], style: const TextStyle(fontSize: 10)),
        Text(
          hexCodes[index],
          style: const TextStyle(fontSize: 9, fontFamily: 'monospace'),
        ),
      ],
    );
  }
}
