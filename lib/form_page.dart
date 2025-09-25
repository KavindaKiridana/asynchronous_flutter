import 'package:flutter/material.dart';

String? username;
String? email;

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formstate,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              textname(),
              textemail(),
              ElevatedButton(
                onPressed: () {
                  if (_formstate.currentState!.validate()) {
                    _formstate.currentState!.save();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textname() {
  return TextFormField(
    decoration: InputDecoration(hintText: 'your name'),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "name cannot be null";
      }
      return null;
    },
    onSaved: (newValue) {
      username = newValue;
    },
  );
}

Widget textemail() {
  return TextFormField(
    decoration: InputDecoration(hintText: 'your email'),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "email cannot be null";
      }
      return null;
    },
    onSaved: (newValue) {
      email = newValue;
    },
  );
}
