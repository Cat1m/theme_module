import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final currentTheme = themeProvider.currentTheme;
    final isDeepSpace = currentTheme.id.contains('deep_space');
    final isPurple = currentTheme.id.contains('purple');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Module Demo'),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Feature Banners
            _buildFeatureBanners(context, isPurple, isDeepSpace),

            const SizedBox(height: 24),

            // Theme Preview
            Text(
              'Theme Preview',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),

            const SizedBox(height: 32),

            // Theme Quick Picker
            Text(
              'Quick Change Theme',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),

            // Purple theme picker (if using purple theme)
            if (isPurple) _buildPurpleThemePicker(context),

            const SizedBox(height: 16),

            const SizedBox(height: 16),

            const SizedBox(height: 32),

            // Sample content to demonstrate theme
            Text(
              'Sample Content',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Example',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This is a sample card to show how the current theme affects card appearance. You can change themes above to see the differences.',
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
                          child: const Text('SUBMIT'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Form example
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    currentTheme.options.borderRadius,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    currentTheme.options.borderRadius,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Button examples
            Text(
              'Button Styles',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Elevated Button'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined Button'),
                ),
                TextButton(onPressed: () {}, child: const Text('Text Button')),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFeatureBanners(
    BuildContext context,
    bool isPurple,
    bool isDeepSpace,
  ) {
    return Column(
      children: [
        // Purple Theme Banner
        if (isPurple)
          _buildFeatureBanner(
            context,
            title: 'Custom Purple Theme',
            description: 'Explore the Deep Purple theme (#4d2962)',
            color: PurpleThemeCreator.purpleColor,
            icon: Icons.palette,
            onTap: () {},
          ),

        if (isPurple) const SizedBox(height: 12),

        // Deep Space Banner
        if (isDeepSpace)
          _buildFeatureBanner(
            context,
            title: 'Deep Space Theme',
            description: 'Explore Deep Space gradient themes',
            color: Color(0xFF112C71),
            icon: Icons.nightlight_round,
            onTap: () {},
          ),

        if (isDeepSpace) const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildFeatureBanner(
    BuildContext context, {
    required String title,
    required String description,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPurplePreview(BuildContext context) {
    ThemeProvider.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: PurpleThemeCreator.purpleColor.withValues(alpha: 0.2),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Purple color
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: PurpleThemeCreator.purpleColor),
              child: Row(
                children: [
                  const Icon(Icons.palette, color: Colors.white, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    'Deep Purple Theme',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '#4d2962',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content of the card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Color palette preview
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        PurpleThemeCreator.getComplementaryColors()
                            .take(4)
                            .map(
                              (color) => Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
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
                            )
                            .toList(),
                  ),

                  const SizedBox(height: 16),

                  // Buttons preview
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('BUTTON'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('OUTLINE'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Text field preview
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Input Field',
                      hintText: 'Sample text input',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurpleThemePicker(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final purpleThemes = PurpleThemeCreator.createPurpleThemes();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: PurpleThemeCreator.purpleColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PurpleThemeCreator.purpleColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.color_lens,
                color: PurpleThemeCreator.purpleColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Purple Themes',
                style: TextStyle(
                  color: PurpleThemeCreator.purpleColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: purpleThemes.length,
              itemBuilder: (context, index) {
                final theme = purpleThemes[index];
                final isSelected = theme.id == themeProvider.currentTheme.id;

                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: InkWell(
                    onTap: () {
                      // Thêm theme vào provider nếu chưa có
                      themeProvider.addTheme(theme);
                      // Đặt theme làm theme hiện tại
                      themeProvider.setTheme(theme.id);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 80,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: theme.backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              isSelected
                                  ? theme.primaryColor
                                  : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow:
                            isSelected
                                ? [
                                  BoxShadow(
                                    color: theme.primaryColor.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ]
                                : null,
                      ),
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
                                color: theme.textColor.withValues(alpha: 0.3),
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
                            theme.name.replaceAll('Purple ', ''),
                            style: TextStyle(
                              color: theme.textColor,
                              fontSize: 12,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
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
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.open_in_new, size: 16),
              label: const Text('More Options'),
            ),
          ),
        ],
      ),
    );
  }
}
