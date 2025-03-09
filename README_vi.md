# Theme Module

Một package Flutter đơn giản để quản lý theme cho ứng dụng với nhiều tùy chọn và dễ dàng tích hợp, bao gồm bộ theme Deep Space đẹp mắt.

## Tính năng

- 🎨 Quản lý nhiều theme (sáng, tối, và tùy chỉnh)
- 🌈 Tự động lưu và khôi phục theme đã chọn
- 🎭 Dễ dàng chuyển đổi giữa các theme
- 🧩 API đơn giản và trực quan
- 🚀 Bộ theme Deep Space đẹp mắt với gradient từ xanh đến tím
- 🛠️ Tiện ích tùy chỉnh theme
- 📱 Widget hiển thị và chọn theme

## Cài đặt

Thêm `theme_module` vào file `pubspec.yaml` của project:

```yaml
dependencies:
  flutter:
    sdk: flutter
  theme_module:
    git:
      url: https://github.com/yourusername/theme_module.git
```

## Sử dụng cơ bản

### Khởi tạo theme module

```dart
import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Khởi tạo theme module với các theme mặc định
  await ThemeModule.initialize(
    themes: ThemeUtils.createDefaultThemes(),
    defaultThemeId: 'light',
    useMaterial3: true,
  );
  
  runApp(const MyApp());
}
```

### Sử dụng ThemeProvider

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

## Sử dụng theme Deep Space

### Khởi tạo với bộ theme Deep Space

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Lấy các theme Deep Space
  final deepSpaceThemes = ThemeUtils.createDeepSpaceThemes();
  
  // Khởi tạo module với theme Deep Space
  await ThemeModule.initialize(
    themes: [...ThemeUtils.createDefaultThemes(), ...deepSpaceThemes],
    defaultThemeId: 'deep_space_blue', // Sử dụng Deep Space làm theme mặc định
    useMaterial3: true,
  );
  
  runApp(const MyApp());
}
```

### Hiển thị theme picker style Deep Space

```dart
class ThemePickerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chọn Theme')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deep Space theme picker
            DeepSpaceThemePicker(
              onThemeSelected: (theme) {
                // Xử lý khi theme được chọn
                print('Đã chọn theme: ${theme.name}');
              },
            ),
            
            SizedBox(height: 16),
            
            // Hiển thị xem trước theme
            DeepSpaceThemePreview(),
          ],
        ),
      ),
    );
  }
}
```

## Tùy chỉnh theme

### Tạo theme mới

```dart
// Tạo một theme tùy chỉnh
final myCustomTheme = AppTheme(
  id: 'custom_theme',
  name: 'Theme Của Tôi',
  description: 'Theme tùy chỉnh của tôi',
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

// Thêm theme vào danh sách
ThemeProvider.instance.addTheme(myCustomTheme);

// Áp dụng theme
ThemeProvider.instance.setTheme('custom_theme');
```

### Tạo theme từ Deep Space

```dart
// Tạo Deep Space theme riêng
final deepSpaceCustom = ThemeUtils.createDeepSpaceTheme(
  id: 'my_deep_space',
  name: 'Deep Space Custom',
);

// Thêm vào provider
ThemeProvider.instance.addTheme(deepSpaceCustom);
```

## Ví dụ thực tế

### Ứng dụng media viewer với Deep Space theme

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
                // Hình ảnh hoặc phương tiện
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
                // Thanh tiêu đề
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

## Giấy phép

Package này được phân phối dưới giấy phép MIT.

---

Được tạo bởi [Tên của bạn] với ❤️