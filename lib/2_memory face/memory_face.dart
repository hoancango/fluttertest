import 'package:flutter/material.dart';
import 'package:fluttertest/image_assets.dart';
import 'package:get/get.dart';

class MemoryFace extends StatefulWidget {
  const MemoryFace({super.key});

  @override
  State<MemoryFace> createState() => _MemoryFaceState();
}

class _MemoryFaceState extends State<MemoryFace> {
  RxList<FaceData> data = <FaceData>[].obs;
  int firstIndex = -1;
  int secondIndex = -1;
  int validTouch = 0;
  int runCount = 0;

  @override
  void initState() {
    data.addAll(dataBase);
    data.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Face'),
      ),
      body: Obx(
        () => Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.toList().length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    await saveUserChoices(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    clipBehavior: Clip.antiAlias,
                    child: (data.toList()[index].isFaceUp.value == true)
                        ? Image.asset(
                            data[index].imageAsset,
                            fit: BoxFit.fill,
                          )
                        : Container(
                            color: Colors.grey,
                          ),
                  ),
                );
              },
            ),

            SizedBox(height: 20,),

            InkWell(
              onTap: (){
                resetGame();
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Reset'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveUserChoices(int index) async {

    if (validTouch < 2 && data[index].isFaceUp.value == false) {
      data[index].isFaceUp.value = true;
      data.refresh();
      if (validTouch == 0) {
        firstIndex = index;
        validTouch++;
      }

      if (validTouch == 1 && index != firstIndex) {
        secondIndex = index;
        validTouch++;
      }

      if (firstIndex >= 0 && secondIndex >= 0) {
        runCount++; //runCount dam bao logic chi chay khi can thiet ke ca khi user spam cuc ky nhanh
        if(runCount == 1) {
          if (data[firstIndex].id == data[secondIndex].id) {
            validTouch = 0;
            firstIndex = -1;
            secondIndex = -1;
            runCount = 0;
          } else {
            await Future.delayed(Duration(
              seconds: 1,
            ));
            data[firstIndex].isFaceUp.value = false;
            data[secondIndex].isFaceUp.value = false;
            validTouch = 0;
            firstIndex = -1;
            secondIndex = -1;
            runCount = 0;
          }
        }

      }

    }
    data.refresh();
  }

  void resetGame(){
    for(var e in dataBase){
      e.isFaceUp.value = false;
    }

    data.clear();
    data.addAll(dataBase);
    data.shuffle();
  }

}

List<FaceData> dataBase = [
  FaceData(false.obs, 0, ImageAssets.dalot),
  FaceData(false.obs, 1, ImageAssets.dialo),
  FaceData(false.obs, 2, ImageAssets.martinez),
  FaceData(false.obs, 3, ImageAssets.mount),
  FaceData(false.obs, 4, ImageAssets.onana),
  FaceData(false.obs, 5, ImageAssets.shaw),
  FaceData(false.obs, 0, ImageAssets.dalot),
  FaceData(false.obs, 1, ImageAssets.dialo),
  FaceData(false.obs, 2, ImageAssets.martinez),
  FaceData(false.obs, 3, ImageAssets.mount),
  FaceData(false.obs, 4, ImageAssets.onana),
  FaceData(false.obs, 5, ImageAssets.shaw),
];

class FaceData {
  RxBool isFaceUp;
  int id;
  String imageAsset;

  FaceData(this.isFaceUp, this.id, this.imageAsset);
}
