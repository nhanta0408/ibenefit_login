# iBenefit Interview Test

Có 3 screen: Splash, Login và Home screen/
Sử dụng API để gọi device code. Các device code sẽ có thời gian trong vòng 2 phút.
Login, có check format đơn giản, nhận các lỗi từ server gửi về
Home có Logout (vẫn cần device code trong mỗi lần gọi)

Sử dụng kiến trúc BLoC.
Cache sử dụng Hive
Giao tiếp API sử dụng HTTP

Có sử dụng các widget tự tạo nằm trong file widget.dart
Các dialog đơn giản trong file dialog.dart
Các hằng số trong constant.dart
