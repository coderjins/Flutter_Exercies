import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('금호동3가',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 17,
                ),
              ),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
          actions: <Widget>[
            Icon(Icons.search),
            SizedBox(width: 25),
            Icon(Icons.menu),
            SizedBox(width: 25),
            Icon(Icons.notifications),
            SizedBox(width: 20),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/dog.png'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.0,
                      )
                    ),
                ),
              ),
              Expanded(
                  child:
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('캐논 DSLR 100D (단렌즈, 충전기 16기가 SD 포함',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text('성동구 행당동 . 끌올 10분전 ',
                            style: TextStyle(color: Colors.blueGrey, fontSize: 10),
                          ),
                          Text('210,000원',
                            style: TextStyle(fontWeight:FontWeight.w900),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(Icons.favorite_border), // 첫 번째 아이콘
                              SizedBox(width: 3), // 아이콘 사이 간격
                              Text('4'),
                              SizedBox(width: 10),// 두 번째 아이콘
                            ],
                          )
                        ],
                      ),
                    ),
                  )
              )
            ],
          ),



        ),
      ),
    );
  }
}
