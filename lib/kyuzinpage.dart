import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


class KyuzinPage extends StatefulWidget {
  @override
  _KyuzinPageState createState() => _KyuzinPageState();
}

class _KyuzinPageState extends State<KyuzinPage> {
  String imageUrl = '';
  String cropName = '';
  String dateTime = '';

  late FirebaseDatabase database;

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('求人データの追加'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // フォームフィールド
            TextField(
              decoration: InputDecoration(labelText: '画像URL'),
              onChanged: (value) {
                setState(() {
                  imageUrl = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: '作物名'),
              onChanged: (value) {
                setState(() {
                  cropName = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: '日時'),
              onChanged: (value) {
                setState(() {
                  dateTime = value;
                });
              },
            ),

            // 送信ボタン
            ElevatedButton(
              onPressed: () {
                saveJobListing();
              },
              child: Text('データを保存'),
            ),

          ],
        ),
      ),
    );
  }

  void saveJobListing() {
    // データベースの参照を取得
    DatabaseReference databaseReference = database.ref();

    databaseReference.child("jobListings").push().set({
      'imageUrl': imageUrl,
      'cropName': cropName,
      'dateTime': dateTime
    });
  }
}


