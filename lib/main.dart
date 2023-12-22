import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var a = 1;
  var name= ['유진서','강승찬','청룡이'];
  List likes = [0, 0, 0];
  void _incrementLike(int index) {
    setState(() {
      likes[index]++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Text(a.toString()),
          onPressed:(){
            setState(() {
              a++;
            });
          },
        ),
        appBar: AppBar(title: Text('연락처앱'),),
        //스크롤바 생김, 스크롤 위치 감시도 가능함, 메모리 절약이 가능!
        body: ListView.builder(
            itemCount: name.length,
            itemBuilder: (context, i){
              return ListTile(
                leading: Image.asset(('assets/profile.png')),
                title: Text(name[i]),
                trailing: Row(
                   mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${likes[i]}'), // 좋아요 수 표시
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        onPressed: () => _incrementLike(i),
                      ),// 좋아요 버튼
                  ],
                ),
              );
            },
        ),
        bottomNavigationBar: BottomAppBar(),
      ),
    );

  }
}
//stless 로 커스텀위젯을 만들 수 있다!
class BottomAppBar extends StatelessWidget {
  const BottomAppBar({super.key});
//변수에 담아도 되는 것 -> 평생 안바뀌는거 상단바, 하단바 같은것들 데이터가 바뀐다면 class 커스텀위젯으로 써라
  @override //내꺼먼저 적용해줘(덮어쓰라는 이야기)
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.phone),
          Icon(Icons.message),
          Icon(Icons.info),
        ],
      ),
    );
  }
}

