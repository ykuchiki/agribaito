import 'dart:typed_data';
import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class KyuzinPage extends StatefulWidget {
  @override
  _KyuzinPageState createState() => _KyuzinPageState();
}

class _KyuzinPageState extends State<KyuzinPage> {
  Uint8List? imageBytes;
  String imageUrl = '';
  String cropName = '';
  String dateTime = '';

  late FirebaseDatabase database;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    initFirebaseDatabase();
  }

  Future<void> initFirebaseDatabase() async {
    // Firebase アプリの初期化
    FirebaseApp app = await Firebase.initializeApp();
    // FirebaseDatabase のインスタンスを初期化し、データベースの URL を指定
    database = FirebaseDatabase.instanceFor(
      app: app,
      databaseURL: 'https://agribaito-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

  }

  void pickImage() async {
  try {
    print("画像選択を開始します。");
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      print("画像が選択されました。");

      // Firebase Storageにアップロード
      String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putData(bytes);
      print("Firebase Storageにアップロードしました。");

      final url = await ref.getDownloadURL();
      print("アップロードされた画像URL: $url");

      setState(() {
        imageBytes = bytes;
        imageUrl = url;
      });
    } else {
      print("画像が選択されていません。");
    }
  } catch (e) {
    print("画像選択またはアップロードエラー: $e");
  }
}





  void pickDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      setState(() {
        dateTime = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('求人データの追加'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: pickImage,
              icon: Icon(Icons.image, color: Colors.green),
              label: Text('画像を選択', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
            ),
            SizedBox(height: 10),
            if (imageBytes != null)
              Container(
                child: Image.memory(imageBytes!),
                margin: EdgeInsets.only(bottom: 10),
              ),
            TextField(
              decoration: InputDecoration(labelText: '応募内容', border: OutlineInputBorder()),
              onChanged: (value) {
                setState(() {
                  cropName = value;
                });
              },
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: pickDateTime,
              icon: Icon(Icons.calendar_today, color: Colors.green),
              label: Text('日時を選択', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
            ),
            if (dateTime.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('選択された日時: $dateTime', textAlign: TextAlign.center),
              ),
            ElevatedButton(
              onPressed: () {
                saveJobListing();
              },
              child: Text('データを保存', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
          ],
        ),
      ),
    );
  }


  void saveJobListing() {
  // データベースの参照を取得
  DatabaseReference databaseReference = database.ref();

  try {
    // imageUrlが空でないことを確認
    if (imageUrl.isNotEmpty) {
      databaseReference.child("jobListings").push().set({
        'imageUrl': imageUrl, // Firebase Storageから取得した画像のURL
        'cropName': cropName,
        'dateTime': dateTime
      });
      print('データを保存しました: $imageUrl');
    } else {
      print('画像URLが空です。');
    }
  } catch (e) {
    print('データ保存エラー: $e');
  }
}

}


