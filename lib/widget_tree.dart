import 'package:asynchronous_flutter/asynchronous_page.dart';
import 'package:asynchronous_flutter/form_page.dart';
import 'package:asynchronous_flutter/stream_page.dart';
import 'package:flutter/material.dart';

List<Widget> pages = [FormPage(), AsynchronousPage(), StreamPage()];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  int pageNo = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form - Tutorial 14'),
        backgroundColor: Colors.blueAccent,
      ),
      body: pages.elementAt(pageNo),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.note), label: 'form'),
          NavigationDestination(
            icon: Icon(Icons.signal_wifi_4_bar),
            label: 'asynchronous',
          ),
          NavigationDestination(icon: Icon(Icons.stream), label: 'stream'),
        ],
        onDestinationSelected: (value) {
          setState(() {
            pageNo = value;
          });
        },
        selectedIndex: pageNo,
      ),
    );
  }
}
