import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class MyViewModel with ChangeNotifier {
  String _data = "Initial Data";

  String get data => _data;

  void updateData(String newData) {
    _data = newData;
    notifyListeners();
  }
}

class MyScreen extends StatelessWidget {
  MyViewModel _viewModel = MyViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text(Provider.of<MyViewModel>(context).data),
          ElevatedButton(
            onPressed: () {
              Provider.of<MyViewModel>(context, listen: false)
                  .updateData("New Data");
            },
            child: Text("Update Data"),
          ),
        ],
      ),
    );
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyViewModel(),
      child: MaterialApp(
        home: MyScreen(),
      ),
    );
  }
}
