import "package:flutter/material.dart";
import "package:firebase_database/firebase_database.dart";
import 'package:firebase_core/firebase_core.dart';

class KeisaiPage extends StatefulWidget{
  @override
  _KeisaiPageState createState() => _KeisaiPageState();
}

class _KeisaiPageState extends State<KeisaiPage>{
  String searchKeyword = "";

  @override
  Widget build(BuildContext context){
    // FirebaseDatabase インスタンスの取得
    final FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://agribaito-default-rtdb.asia-southeast1.firebasedatabase.app',
    );
    final DatabaseReference databaseReference = database.ref();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 検索バー
            StreamBuilder<DatabaseEvent>(
              stream: databaseReference.child("jobListings").onValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                
                // Realtime Database から取得したデータを JobListing リストに変換
                List<JobListing> listings = [];
                if (snapshot.data!.snapshot.value != null) {
                  Map<dynamic, dynamic> values = Map<dynamic, dynamic>.from(snapshot.data!.snapshot.value as Map);
                  values.forEach((key, value) {
                    listings.add(JobListing(
                      imageUrl: value['imageUrl'] ?? '',
                      cropName: value['cropName'],
                      dateTime: value['dateTime'],
                    ));
                  });
                }

                // フィルタリングされたリスト
                List<JobListing> filteredListings = listings.where((job) {
                  return job.cropName.toLowerCase().contains(searchKeyword.toLowerCase());
                }).toList();
          
           
            // カード掲載
            return GridView.builder(
              padding: EdgeInsets.all(30), // カードと画面端の間の余白
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2列
                childAspectRatio: 3 / 2, // カードの縦横比を3:2に設定
                crossAxisSpacing: 10, // 列間のスペース
                mainAxisSpacing: 10, // 行間のスペース
              ),
              shrinkWrap: true, // GridViewをColumn内で使用する場合は必要
              physics: NeverScrollableScrollPhysics(), // GridViewのスクロールを無効にする
              itemCount: filteredListings.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0), // カードの角を丸くする
                          child: filteredListings[index].imageUrl.isNotEmpty
                            ? Image.network(
                                filteredListings[index].imageUrl,
                                fit: BoxFit.cover, // 画像をカードのサイズに合わせて調整
                              )
                            : Icon(Icons.image_not_supported, size: 50.0), // 画像がない場合のアイコン
                        ),
                      ),
                      Text(filteredListings[index].cropName),
                      Text(filteredListings[index].dateTime),
                    ],
                  ),
                );
              },
            );
            },
            ),
          ],
        ),
      ),
    );
  }
}

// 以下は仮のリスト
class JobListing {
  String imageUrl;
  String cropName;
  String dateTime;

  JobListing({this.imageUrl = '', required this.cropName, required this.dateTime});
}

List<JobListing> jobListings = [
  JobListing(
    imageUrl: 'assets/image1.jpg',
    cropName: 'トマト',
    dateTime: '2023-04-01'
  ),
  JobListing(
    // imageUrl: 'assets/image2.jpg',
    cropName: 'キュウリ',
    dateTime: '2023-04-15'
  ),
  JobListing(
    // imageUrl: 'assets/image1.jpg',
    cropName: 'トマト',
    dateTime: '2023-04-01'
  ),
  JobListing(
    imageUrl: 'assets/image2.jpg',
    cropName: 'キュウリ',
    dateTime: '2023-04-15'
  ),
  JobListing(
    imageUrl: 'assets/image1.jpg',
    cropName: 'トマト',
    dateTime: '2023-04-01'
  ),
  JobListing(
    imageUrl: 'assets/image2.jpg',
    cropName: 'キュウリ',
    dateTime: '2023-04-15'
  ),
];
