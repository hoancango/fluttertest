
1_ pendulum

Hướng giải đầu tiên em nghĩ tới trước khi tham khảo là cố gắng tạo ra một điểm dao động theo đường cong ,rồi từ điểm đó để nối dây và vẽ vòng tròn.

Tuy nhiên, em không rõ cách làm animation trong dart nên phải tham khảo chatGPT bằng câu hỏi "Cách mô phỏng chuyển động con lắc đơn trong flutter" và chatGPT đưa ra code như trong file chatGPTPendulum.dart

Những điểm quan trọng trong code của GPT:
- Tween để tạo giá trị dao động trong một khoảng
- Animation controller để tạo hiệu ứng và chuyển động
- Custom painter để vẽ bằng cách dùng biến canvas vẽ dây nối và vật nặng, cuối cùng là shouldrepaint trả ra true để luôn cập nhật hình ảnh theo giá trị của tween tạo ra

KẾT QUẢ

(GIF)

  <img src="https://github.com/user-attachments/assets/ce2d76c1-7782-4177-a134-658de6043730" width="300"/>
