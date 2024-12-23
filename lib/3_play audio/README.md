
3_ play_audio

Hướng giải của em là dùng split để tạo ra list các chữ cái từ data cho sẵn.
Sau đó, Sử dụng RichText kết hợp List.generate để in ra một loạt từ và có được index của từng từ.
Dùng dữ liệu time elapsed và số chữ cái trong data so sánh với timer chu kỳ 1ms đang chạy để bắt được chuẩn theo giọng đọc và ghi lại tất cả các index của chữ cái đang đọc, và xử lý thay đổi highlight dựa trên index này bằng obx và biến quan sát.
Dùng thư viện để phát file wav tích hợp vào nút bấm để kích hoạt timer và bắt đầu video cùng lúc.

KẾT QUẢ:
