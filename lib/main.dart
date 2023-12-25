import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락됨');
      refreshContacts();
    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request();
    }
  }

  List<Contact> contacts = []; // 연락처 목록을 저장할 변수

  // 연락처 목록을 새로고침하는 함수
  refreshContacts() async {
    var newContacts = await ContactsService.getContacts();
    setState(() {
      contacts = newContacts;
    });
  }

  @override
  build(context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return DialogUI(
                onSubmitted: (inputName) async {
                  var newPerson = Contact();
                  // 이름 분리 (예시: '내린천 별빛')
                  var names = inputName.split(' ');
                  if (names.length > 1) {
                    newPerson.givenName = names[0]; // 주어진 이름
                    newPerson.familyName = names[1]; // 가족 이름
                  } else {
                    newPerson.givenName = inputName; // 이름만 있는 경우
                  }
                  await ContactsService.addContact(newPerson); // 연락처에 추가
                  refreshContacts(); // 연락처 목록 새로고침
                },
              );
            },
          );
        },
      ),
      appBar: AppBar(
        title: Text('연락처앱'),
        actions: [
          IconButton(onPressed: getPermission, icon: Icon(Icons.contacts))
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Image.asset('assets/profile.png'),
            title: Text(contacts[i].givenName ?? ''), // 연락처 이름 표시
          );
        },
      ),
      bottomNavigationBar: const BottomAppBar(),
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

class DialogUI extends StatelessWidget {
  final Function(String) onSubmitted;
  final String hintText;

  DialogUI({Key? key, required this.onSubmitted, this.hintText = "여기에 입력하세요"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String inputText = '';

    return AlertDialog(
      title: Text('텍스트 입력'),
      content: TextField(
        onChanged: (value) {
          inputText = value;
        },
        decoration: InputDecoration(hintText: hintText),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('취소'),
          onPressed: () {
            Navigator.pop(context); // 다이얼로그 닫기
          },
        ),
        TextButton(
          child: Text('완료'),
          onPressed: () {
            onSubmitted(inputText);
            Navigator.of(context).pop(); // 다이얼로그 닫기
          },
        ),
      ],
    );
  }
}
