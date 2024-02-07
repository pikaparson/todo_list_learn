import 'package:flutter/material.dart';
import 'sql_helper.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('Список дел'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text(
              'Main screen',
              style: TextStyle(
                  color: Colors.white
              ),),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/todo');
                },
                child: Text('Перейти далее')),
          ],
        ),
    );;
  }
}
