import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:posttest/dataa.dart';

void main() {
  runApp(MaterialApp(home: posttest(),));
}
class posttest extends StatefulWidget {
  const posttest({Key? key}) : super(key: key);

  @override
  State<posttest> createState() => _posttestState();
}

class _posttestState extends State<posttest> {
  List<dataa> list=[];

  get() async {
    //get-1 ,post-2
    var url = Uri.parse('https://vanditflutter.000webhostapp.com/text.php');
    var response = await http.post(url);
    //string to json
    dynamic result=jsonDecode(response.body);
    list.clear();
    result.forEach((element) {
      print(element);
      setState(() {
        list.add(dataa.fromJson(element));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(itemCount: list.length,itemBuilder: (context, index) {
        return ListTile(
          title: Text("${list[index].data![index].landmark}"),
        );
      },),
    );
  }
}
