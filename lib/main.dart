import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:api/add.dart';
import 'package:api/model.dart';
import 'package:api/repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crud APi',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: {
        '/home': (context) => MyHomePage(name: 'CrudAPi'),
        '/add': (context) => Add(),
      },
      debugShowCheckedModeBanner: false,
      home: MyHomePage(name: 'Nama Atlit Gateball'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Users> listUsers = [];
  Repository repository = Repository();

  getData() async {
    listUsers = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).popAndPushNamed('/add'),
          )
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).popAndPushNamed('/add',
                      arguments: [
                        listUsers[index].id,
                        listUsers[index].name,
                        listUsers[index].description
                      ]),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listUsers[index].name,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(listUsers[index].description),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      bool response =
                          await repository.deleteData(listUsers[index].id);
                      if (response) {
                        print('Delete Data Success');
                      } else {
                        print('Delete Data Failed');
                      }
                      getData();
                    },
                    icon: Icon(Icons.delete))
              ],
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: listUsers.length),
    );
  }
}
