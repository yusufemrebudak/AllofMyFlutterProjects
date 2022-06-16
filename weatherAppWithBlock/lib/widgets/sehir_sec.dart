import 'package:flutter/material.dart';

class SehirSecWidget extends StatefulWidget {
  SehirSecWidget({Key? key}) : super(key: key);

  @override
  State<SehirSecWidget> createState() => _SehirSecWidgetState();
}

class _SehirSecWidgetState extends State<SehirSecWidget> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Şehir Seç"),
      ),
      body: Form(
          child: Row(
        children: [
          Expanded(
            // sıkıntı çıktığında bunu bir expanded a al
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                    labelText: 'Şehir',
                    hintText: 'Şehir Seçin',
                    border: OutlineInputBorder()),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context, _textController.text);
              },
              icon: const Icon(Icons.search))
        ],
      )),
    );
  }
}
