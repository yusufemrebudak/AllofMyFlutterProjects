import 'package:flutter/material.dart';
import 'package:flutter_stream_block_ders_anlatimi/sayac_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final SayacViewModel sayacViewModel = SayacViewModel();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          initialData: sayacViewModel.init(),
          stream: sayacViewModel.sayacStream, 
          builder: (context, snapshot)=>Text(title+" ${snapshot.data}"))
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>( // streame yeni değerler gelince buraso tetiklenir ve son değer buraya yazılır.
                initialData: sayacViewModel.init(),
                stream: sayacViewModel
                    .sayacStream, // bunu veriyorum ki bunun içindeki sayacStream i
                //sürekli takip et diyorum,
                builder: ((context, snapshot) => Text(
                      snapshot.hasData
                          ? snapshot.data.toString()
                          : "Değer yoktur",
                      style: Theme.of(context).textTheme.headline4,
                    ))),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              sayacViewModel.arttir();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 5,
          ),
          FloatingActionButton(
            onPressed: () {
              sayacViewModel.azalt();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}
