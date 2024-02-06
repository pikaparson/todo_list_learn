import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List todoList = [];

  late String _userToDo;

  @override
  void initState() {
    super.initState();

    todoList.addAll(['Отправить документы', 'Сделать приложение-резюме', 'Приготовить ужин']);
  }

  void menuOpen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(title: Text('Меню')),
              body: Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => true);
                      },
                      child: Text('На главную')),
                  Padding(padding: EdgeInsets.only(left:20)),
                  Text('Наше простое приложение')
                ],
              )
          );
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Список дел'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                menuOpen();
              },
              icon: Icon(Icons.menu_book_outlined)),
        ],
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(todoList[index]),
            child: Card(
              child: ListTile(
                title: Text(todoList[index]),
                trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        todoList.removeAt(index);
                      });
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.blueAccent,
                    )
                ),
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart || direction == DismissDirection.startToEnd) {
                setState(() {
                  todoList.removeAt(index);
                });
              }
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton (
          onPressed: () {
            showDialog(
                context: context, //context - страничка, на которой мы все выполняем
                builder: (BuildContext context) { //как функция
                  return AlertDialog(
                      title: Text('Добавить дело'),
                      content: TextField( // ввод инфы пользователем
                        onChanged: (String value) {
                          _userToDo = value; // без setstate, т.к. пользователю инфа не видна
                        }, // срабатывает при вводе инфы
                      ),
                      actions: [ // добавим кнопки, с помощью массива будет легче
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                todoList.add(_userToDo);
                              });
                              Navigator.of(context).pop(); //закрывает все вспоывающие окна
                            },
                            child: Text('Добавить')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(); //закрывает все вспоывающие окна
                            },
                            child: Text('Отмена')),
                        ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Об авторе'),
                                      content: Text('Разработчик: Качаева Софья, студент 3 курса ТУСУР, группа 581. Все права защищены. 2024 год.'),
                                      actions: [ElevatedButton(onPressed: () {Navigator.of(context).pop();}, child: Text('Выйти'))],
                                    );
                                  });
                            },
                            child: Text('А может об авторе?')),
                      ]
                  );
                });
          },
          child: Icon(
            Icons.add_box,
            color: Colors.blueGrey[600],
          )
      ),

    );
  }
}
