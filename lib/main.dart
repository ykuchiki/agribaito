import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "firebase_options.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

import "package:agribaito/mypage.dart";
import "package:agribaito/studypage.dart";
import "package:agribaito/keisaipage.dart";
import "package:agribaito/kyuzinpage.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  print('API Key: ${dotenv.env['ANDROID_FIREBASE_API_KEY']}');

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env['ANDROID_FIREBASE_API_KEY']!,
      appId: dotenv.env['ANDROID_FIREBASE_APP_ID']!,
      messagingSenderId: dotenv.env['ANDROID_FIREBASE_MESSAGING_SENDER_ID']!,
      projectId: dotenv.env['ANDROID_FIREBASE_PROJECT_ID']!,
      storageBucket: dotenv.env['ANDROID_FIREBASE_STORAGEBUCKET']!,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "AgriBaito",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget{
  const Home() : super();
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  // 選択中フッターメニューのインデックスを一時保存するための変数
  int selectedIndex = 1;

  // 切り替える画面のリスト
  List<Widget> display = [StudyPage(), KeisaiPage(), MyPage(), KyuzinPage()];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: display[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.note_alt), label: "勉強"),
          BottomNavigationBarItem(icon: Icon(Icons.travel_explore), label: "応募一覧"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label:"マイページ"),
          BottomNavigationBarItem(icon: Icon(Icons.science), label:"求人ページ(仮)"),
        ],
        // 現在選択されているフッターメニューのインデックス
        currentIndex: selectedIndex,
        // フッター領域の影
        elevation: 8,
        // フッターメニュータップ時の処理
        onTap: (int index){
          selectedIndex = index;
          setState(() {});
        },
        // 選択中フッターメニューの色
        fixedColor: Colors.red,
        unselectedItemColor: Colors.grey, // 選択されていないアイテム
      ),
    );
  }
}
