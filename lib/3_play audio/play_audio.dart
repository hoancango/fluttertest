import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PlayAudio extends StatefulWidget {
  const PlayAudio({super.key});

  @override
  State<PlayAudio> createState() => _PlayAudioState();
}

class _PlayAudioState extends State<PlayAudio> {
  int selectedIndex = 0;
  List<String> stringList = [];
  List<List<int>> timeStamp = [];
  Stream<int>? timeStream;
  Timer? _timer;
  StreamSubscription<int>? _subscription;
  int currentTimeStampIndex = 0;
  RxList<int> currentTextIndexes = <int>[].obs;
  final AudioPlayer _audioPlayer = AudioPlayer();
  RxInt touchCount = 0.obs;

  @override
  void initState() {
    timeStamp = data['timestamp'];
    stringList = splitText(data['text']);
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Audio'),
      ),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  children: List.generate(stringList.length, (index) {
                    return TextSpan(
                      text: stringList[index],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        backgroundColor:
                            (currentTextIndexes.toList().contains(index))
                                ? Colors.yellow
                                : null,
                      ),
                    );
                  }),
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  touchCount.value++;

                  if (touchCount.value % 2 == 1) {
                    currentTimeStampIndex = 0;
                    currentTextIndexes.clear();
                    // startStream(); // too slow
                    await playAudio('output.wav');
                    startTimer();
                  } else {
                    stopTimer();
                    currentTimeStampIndex = 0;
                    currentTextIndexes.clear();
                    touchCount.value = 0;
                    // stopStream(); //
                    await stopAudio();
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.grey, shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: (touchCount.value % 2 == 0)?const Icon(Icons.play_arrow):const Icon(Icons.stop),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> splitText(String text) {
    return text.split('');
  }

  void manageIndexes(int count) {
    if (count >= timeStamp[currentTimeStampIndex][0]) {
      final wordIndex = timeStamp[currentTimeStampIndex][2];
      final wordLength = timeStamp[currentTimeStampIndex][3];
      final currentIndexes =
          List.generate(wordLength, (index) => wordIndex + index);
      currentTextIndexes.clear();
      currentTextIndexes.addAll(currentIndexes);
      if (currentTimeStampIndex < timeStamp.length - 1) {
        currentTimeStampIndex++;
      }
    }
  }

  void startStream() {
    _subscription?.cancel();
    timeStream =
        Stream.periodic(const Duration(milliseconds: 1), (int count) => count);
    _subscription = timeStream?.listen((event) {
      if (event == timeStamp[currentTimeStampIndex][0]) {
        manageIndexes(event);
      }
    });
  }

  void stopStream() {
    _subscription?.cancel();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      final count = timer.tick - 1;
      if (count >= timeStamp[currentTimeStampIndex][0]) {
        manageIndexes(count);
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  Future<void> playAudio(String audioPath) async {
    await _audioPlayer.play(AssetSource(audioPath));
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }
}

Map<String, dynamic> data = {
  "text":
      "Hỡi đồng bào cả nước,\n\n\"Tất cả mọi người đều sinh ra có quyền bình đẳng. Tạo hóa cho họ những quyền không ai có thể xâm phạm được; trong những quyền  ấy, có quyền được sống, quyền tự do và quyền mưu cầu hạnh phúc\".\n\nLời bất hủ ấy ở trong bản Tuyên ngôn độc lập năm 1776 của nước Mỹ. Suy rộng ra, câu ấy có ý nghĩa là: tất cả các dân tộc trên thế giới đều sinh ra bình đẳng; dân tộc nào cũng có quyền sống, quyền sung sướng và quyền tự do.",
  "timestamp": [
    [50, 188, 0, 3],
    [287, 113, 4, 4],
    [487, 150, 9, 3],
    [712, 113, 13, 2],
    [850, 225, 16, 4],
    [1075, 63, 20, 1],
    [1975, 213, 23, 4],
    [2237, 125, 28, 2],
    [2387, 188, 31, 3],
    [2625, 188, 35, 5],
    [2862, 150, 41, 3],
    [3037, 250, 45, 4],
    [3312, 175, 50, 2],
    [3575, 63, 53, 2],
    [3725, 163, 56, 5],
    [3937, 163, 62, 4],
    [4137, 338, 67, 4],
    [4500, 25, 71, 1],
    [5362, 250, 73, 3],
    [5625, 250, 77, 3],
    [5962, 113, 81, 3],
    [6075, 200, 85, 2],
    [6325, 225, 88, 5],
    [6562, 238, 94, 5],
    [6800, 238, 100, 5],
    [7075, 150, 106, 2],
    [7312, 63, 109, 2],
    [7425, 113, 112, 3],
    [7575, 238, 116, 3],
    [7812, 225, 120, 4],
    [8087, 188, 125, 4],
    [8362, 113, 129, 1],
    [8575, 138, 131, 5],
    [8775, 200, 137, 5],
    [8975, 213, 143, 5],
    [9212, 163, 150, 2],
    [9500, 175, 152, 1],
    [9737, 75, 154, 2],
    [9887, 200, 157, 5],
    [10112, 125, 163, 4],
    [10262, 325, 168, 4],
    [10612, 213, 172, 1],
    [10850, 238, 174, 5],
    [11137, 138, 180, 2],
    [11350, 213, 183, 2],
    [11575, 113, 186, 2],
    [11787, 175, 189, 5],
    [12037, 163, 195, 3],
    [12275, 150, 199, 3],
    [12450, 200, 203, 4],
    [12662, 225, 208, 4],
    [12887, 38, 212, 2],
    [13750, 263, 216, 3],
    [14050, 175, 220, 3],
    [14287, 175, 224, 2],
    [14487, 150, 227, 2],
    [14687, 125, 230, 1],
    [14887, 88, 232, 5],
    [15062, 200, 238, 3],
    [15350, 125, 242, 5],
    [15562, 175, 248, 4],
    [15787, 150, 253, 3],
    [15950, 175, 257, 3],
    [16137, 150, 261, 3],
    [16287, 1550, 265, 4],
    [17912, 75, 270, 3],
    [18012, 175, 274, 4],
    [18212, 225, 279, 2],
    [18550, 50, 281, 1],
    [19437, 250, 283, 3],
    [19737, 200, 287, 4],
    [19975, 213, 292, 2],
    [20212, 188, 294, 1],
    [20487, 150, 296, 3],
    [20662, 113, 300, 2],
    [20875, 75, 303, 2],
    [21000, 88, 306, 1],
    [21175, 163, 308, 5],
    [21362, 263, 314, 2],
    [21650, 188, 316, 1],
    [21950, 138, 318, 3],
    [22150, 125, 322, 2],
    [22350, 125, 325, 3],
    [22550, 175, 329, 3],
    [22787, 163, 333, 3],
    [23037, 125, 337, 4],
    [23212, 88, 342, 3],
    [23375, 200, 346, 4],
    [23612, 150, 351, 3],
    [23787, 250, 355, 4],
    [24050, 113, 360, 2],
    [24200, 188, 363, 4],
    [24412, 338, 368, 4],
    [24800, 125, 372, 1],
    [24962, 175, 374, 3],
    [25200, 150, 378, 3],
    [25375, 250, 382, 3],
    [25700, 138, 386, 4],
    [25862, 50, 391, 2],
    [25987, 188, 394, 5],
    [26200, 325, 400, 4],
    [26550, 200, 404, 1],
    [26787, 213, 406, 5],
    [27025, 225, 412, 4],
    [27275, 338, 417, 5],
    [27625, 113, 423, 2],
    [27825, 225, 426, 5],
    [28100, 138, 432, 2],
    [28287, 225, 435, 2],
    [28562, 0, 437, 1]
  ]
};
