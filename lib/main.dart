import 'package:flutter/material.dart';
import 'package:flutter_mvvm_mobx_hwa/features/post/view/post_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: PostView(),
    );
  }
}