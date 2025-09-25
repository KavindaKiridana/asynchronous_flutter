import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AsynchronousPage extends StatefulWidget {
  const AsynchronousPage({super.key});

  @override
  State<AsynchronousPage> createState() => _AsynchronousPageState();
}

class _AsynchronousPageState extends State<AsynchronousPage> {
  @override
  void initState() {
    super.initState();
    gateData();
  }

  Future<String> gateData() async {
    String output;
    var url = Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': '{http}',
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['totalItems'];
      output = 'Number of books about http: $itemCount.';
    } else {
      output = 'Request failed with status: ${response.statusCode}.';
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: gateData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Container(child: Text(snapshot.data));
          }
        },
      ),
    );
  }
}
