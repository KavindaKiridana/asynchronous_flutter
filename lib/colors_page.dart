import 'dart:async';
import 'dart:convert' as convert;
import 'package:asynchronous_flutter/title_color.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ColorsPage extends StatefulWidget {
  const ColorsPage({super.key});

  @override
  State<ColorsPage> createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {
  final StreamController<TitleColor> _controller =
      StreamController<TitleColor>();

  Future<void> getData() async {
    for (int x = 1; x <= 20; x++) {
      var url = Uri.https(
        'jsonplaceholder.typicode.com',
        '/todos/$x',
      ); //  dynamic id
      var response = await http.get(url);
      int y = colorList.length - x;
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        var title = jsonResponse['title'];
        _controller.sink.add(
          TitleColor(title, colorList.elementAt(x), colorList.elementAt(y)),
        ); //  add title
      } else {
        // _controller.sink.add('Error: ${response.statusCode}');
      }

      // small delay so requests don’t all fire at once
      await Future.delayed(Duration(seconds: 1));

      if (x == 20) {
        x = 1;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    _controller.close(); //  important
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TitleColor>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          final data = snapshot.data!; //  safely unwrap TitleColor
          return Container(
            color: data.backcolor,
            child: Center(
              child: Text(
                data.title,
                style: TextStyle(
                  color: data.color,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(child: Text("No data yet"));
        }
      },
    );
  }
}

List<Color> colorList = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.pink,
  Colors.brown,
  Colors.cyan,
  Colors.indigo,
  Colors.teal,
  Colors.lime,
  Colors.amber,
  Colors.grey,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.blueGrey,
  Colors.black,
  Colors.grey,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.blueGrey,
  Colors.black,
];
