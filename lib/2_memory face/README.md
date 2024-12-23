
2_ memory face

Hướng giải quyết của em là dùng 2 biến firstIndex và secondIndex để ghi lại lựa chọn của player và so sánh chúng với nhau để xử lý logic hiển thị.

Dùng class DataFace với thuộc tính bool kiểm soát trạng thái lật úp, thuộc tính id để so sánh trùng lặp có cơ sở lật úp, và link ảnh asset để hiển thị.

Dùng biến validCount để đếm và đảm bảo chỉ có 2 thẻ lật lên cùng một lúc.

Dùng biến runCount để đảm bảo logic không chạy nhiều dù player có spam cực nhanh.

Ngoài ra em dùng biến quan sát, Obx và lệnh data.refresh của thư viện GetX để cập nhật lại giao diện.

Kết quả:
(GIF)

(GIF)
  
  <img src="https://github.com/user-attachments/assets/f980ccdd-4816-4fe3-9be8-789f75624e25" width="300"/>
