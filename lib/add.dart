import 'package:flutter/material.dart';
import 'package:api/repository.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  Repository repository = Repository();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    if (args[1].isNotEmpty) {
      _nameController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      _descriptionController.text = args[2];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(" Data yang akan diubah dan simpan "),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'Description'),
            ),
            ElevatedButton(
                onPressed: () async {
                  bool response = await repository.postData(
                      _nameController.text, _descriptionController.text);

                  if (response) {
                    Navigator.of(context).popAndPushNamed('/home');
                  } else {
                    print('Post Data Gagal!');
                  }
                },
                child: Text('Submit')),
            ElevatedButton(
                onPressed: () async {
                  bool response = await repository.putData(int.parse(args[0]),
                      _nameController.text, _descriptionController.text);
                  if (response) {
                    Navigator.of(context).popAndPushNamed('/home');
                  } else {
                    print('Post Data Gagal!');
                  }
                },
                child: Text('Update'))
          ],
        ),
      ),
    );
  }
}
