# Đề thi lập trình Flutter ứng tuyển tại Techmaster

Đây là đề thi dành cho thực tập sinh Flutter muốn [tham gia dự án ứng dụng di động học trực tuyến ](https://techmaster.vn/posts/38275/techmaster-tuyen-sinh-vien-thuc-tap-mobile-flutter-c-va-ai-2025).

Mục tiêu đề thi để đánh giá khả năng tìm kiếm giải pháp, xử lý vấn đề của sinh viên hơn là kiểm tra kỹ năng lập trình giao diện di động (giờ AI đã làm hộ rất nhiều rồi). Đề thi gồm có nhiều bài từ dễ đến khó để sinh viên luyện tập dần. Thời gian lập trình trong 7 ngày. Hãy tích cực hỏi ChatGPT hoặc Claude Sonnet để tìm giải pháp.

## Hướng dẫn làm và nộp bài
1. Cứ mạnh dạn hỏi ChatGPT và Claude Sonnet.
2. Tạo một github repo trên github chia thành các thư mục 01, 02, 03, 04 để đánh số các bài.
3. Làm được càng nhiều càng tốt nhưng không nhất thiết tất cả các bài.
4. Trong lúc làm khó gì cứ hỏi tôi (Cường ở số Zalo 0902209011)
5. Trong mỗi thư mục lưu một dự án Flutter giải quyết yêu cầu hãy viết file ReadMe.md chụp lại màn hình kết quả bạn đã làm và mô tả cách giải quyết của bạn hoặc prompt bạn đã hỏi AI để giải quyết
## 01 Mô phỏng con lắc đơn (10 điểm)
Hãy lập trình hoạt hình mô phỏng con lắc đơn
![Con lắc đơn](pendulum.webp)

## 02 Memory Face (20 điểm)
![Memory Face](memoryface.webp)
Ứng dụng Memory Faces. Hãy vẽ ảnh những nhân vật nổi tiếng theo cặp, sau đó che bằng hình tròn xám. Người chơi ấn chuột vào hình tròn xám, mặt nhân vật nổi tiếng
sẽ hiện ra. Tại một thời điểm không được lật quá 2 hình tròn xám. Nếu hai mặt của cùng
một nhân vật thì giữ nguyên, còn không sẽ lật cả hai về hình tròn xám. Trò chơi kết thúc, khi người dùng mở được toàn bộ các hình tròn xám
## 04 Play audio (40 điểm)
Hãy lập trình ứng dụng đọc sách: âm thanh phát đồng thời đánh dấu từ đang phát âm. Xem video [HighLightWord.mp4](HighLightWord.mp4)
![WordSync](https://media.techmaster.vn/api/static/36/DzTmENxO)

Bạn được cung cấp 2 file:
- output.wav
- output.json
Cấu trúc của file output.json gồm 2 trường:
- "text": bài văn đọc
- "timestamp":  mảng các mảng con. Mỗi mảng con có 4 phần tử:
   - *time ellapsed*: thời gian đã trôi qua kể từ lúc file wav được phát. Tính theo mili-second
   - *word duration*: thời gian để phát âm từ hiện tại sắp được phát âm. Tính theo mili-second
   - *word index*: Vị trí của ký tự đầu tiên của từ hiện tại sắp được phát âm
   - *word length*: Độ dài từ hiện tại sắp được phát âm.

Như vậy mảng "timestamp" cung cấp đầy đủ thông tin để
```js:output.json
{
  "text": "Hỡi đồng bào cả nước,\n\n\"Tất cả mọi người đều sinh ra có quyền bình đẳng. Tạo hóa cho họ những quyền không ai có thể xâm phạm được; trong những quyền  ấy, có quyền được sống, quyền tự do và quyền mưu cầu hạnh phúc\".\n\nLời bất hủ ấy ở trong bản Tuyên ngôn độc lập năm 1776 của nước Mỹ. Suy rộng ra, câu ấy có ý nghĩa là: tất cả các dân tộc trên thế giới đều sinh ra bình đẳng; dân tộc nào cũng có quyền sống, quyền sung sướng và quyền tự do.",
  "timestamp": [
    [
      50,
      188,
      0,
      3
    ],
...
  ]
}
```

Gợi ý hãy tạo một timer có chu kỳ khoảng 1 mili-second để so sánh *time ellapsed* với thời gian tính từ lúc file wav được phát để tìm ra từ cần ==highlight bôi vàng==
## 05 Giải phương trình bậc 2 (30 điểm)
Vẽ một màn hình gồm 3 trường nhận 3 số thập phân: a, b và c thể hiện phương trình bậc 2:
$a^2 + b^2 = c^2 = 0$
Viết một hàm giải phương trình bậc 2 bằng ngôn ngữ C, sau đó từ Flutter gọi hàm này để giải phương trình rồi sau đó trả về kết quả hiển thị trong màn hình Flutter.

Hãy tham khảo [Tích hợp thư viện C/C++ vào một dự án Flutter như thế nào?](https://viblo.asia/p/tich-hop-thu-vien-cc-vao-mot-du-an-flutter-nhu-the-nao-V3m5WmE7ZO7)
