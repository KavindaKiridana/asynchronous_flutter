import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({super.key});

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  final StreamController<String> _controller = StreamController<String>();

  Future<void> getData() async {
    for (int x = 1; x <= 20; x++) {
      var url = Uri.https(
        'jsonplaceholder.typicode.com',
        '/todos/$x',
      ); // ✅ dynamic id
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        var title = jsonResponse['title'];
        _controller.sink.add(title.toString()); // ✅ add title
      } else {
        _controller.sink.add('Error: ${response.statusCode}');
      }

      // small delay so requests don’t all fire at once
      await Future.delayed(Duration(seconds: 1));
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    _controller.close(); // ✅ important
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return Center(
            child: Text(
              snapshot.data.toString(),
              style: TextStyle(fontSize: 18),
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
