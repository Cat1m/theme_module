# Example App for Theme Module

Ứng dụng ví dụ để demo package `theme_module` và tính năng Deep Space Theme.

## Cách chạy

1. Đảm bảo bạn đã cài đặt Flutter SDK
2. Clone repository này
3. Cd vào thư mục example: `cd example`
4. Lấy các dependencies: `flutter pub get`
5. Chạy ứng dụng: `flutter run`

## Tính năng Demo

- Demo tất cả các theme bao gồm theme Deep Space
- Chuyển đổi giữa các theme
- Xem trước theme
- Trang cài đặt theme
- Các UI element demo với theme đã chọn

## Screenshots

(Các ảnh chụp màn hình sẽ được thêm vào sau khi chạy)

## Cấu trúc

- `lib/main.dart`: Điểm vào của ứng dụng, khởi tạo theme module
- `lib/screens/home_page.dart`: Trang chính hiển thị danh sách theme và các UI element demo
- `lib/screens/theme_settings_page.dart`: Trang cài đặt để tùy chỉnh theme