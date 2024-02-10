import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String _email = '';
  String _password = '';
  String _accountType = '農家';
  late FirebaseDatabase database;

  @override
  void initState() {
    super.initState();
    // FirebaseDatabase のインスタンスを初期化
    database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://agribaito-default-rtdb.asia-southeast1.firebasedatabase.app',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            // ユーザーがログインしている場合のUI
            return _loggedInUI(snapshot.data!);
          } else {
            // ログインしていない場合のUI
            return _loginFormUI();
          }
        },
      ),
    );
  }

  Widget _loggedInUI(User user) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ログイン中: ${user.email}'),
            FutureBuilder<DataSnapshot>(
              future: FirebaseDatabase.instance.ref('users/${user.uid}').get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userData = snapshot.data!.value as Map<dynamic, dynamic>;
                  return Text('アカウントタイプ: ${userData['accountType']}');
                }
                return CircularProgressIndicator();
              },
            ),
            ElevatedButton(
              child: const Text('ログアウト'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginFormUI() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'メールアドレス'),
              onChanged: (value) => _email = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'パスワード'),
              obscureText: true,
              onChanged: (value) => _password = value,
            ),
            DropdownButton<String>(
              value: _accountType,
              onChanged: (String? newValue) {
                setState(() {
                  _accountType = newValue!;
                });
              },
              items: <String>['農家', 'アルバイト']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
            child: const Text('ユーザ登録'),
            onPressed: () async {
              try {
                UserCredential userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(email: _email, password: _password);

                // 現在のユーザーを取得
                User? currentUser = FirebaseAuth.instance.currentUser;

                if (currentUser != null) {
                  // ユーザー情報の保存
                  DatabaseReference userRef = FirebaseDatabase.instance.ref('users/${currentUser.uid}');
                  await userRef.set({'accountType': _accountType});
                  print("ユーザ登録しました: ${currentUser.email}");
                }
                } catch (e) {
                  print("ユーザ登録失敗: $e");
                }
              },
            ),
            ElevatedButton(
              child: const Text('ログイン'),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(email: _email, password: _password);
                } catch (e) {
                  print("ログイン失敗: $e");
                }
              },
            ),
            ElevatedButton(
              child: const Text('パスワードリセット'),
              onPressed: () async {
                            try {
                await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
                print("パスワードリセットメールを送信しました");
            } catch (e) {
                print("パスワードリセット失敗: $e");
            }
          },
        ),
      ],
    ),
  ),
);
}
}