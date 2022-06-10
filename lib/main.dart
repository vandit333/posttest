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
  dataa? m;
  bool isLoding=true;

  get() async {
    //get-1 ,post-2
    var url = Uri.parse('https://vanditflutter.000webhostapp.com/text.php');
    var response = await http.post(url);
    //string to json
    Map<String, dynamic> result=jsonDecode(response.body);
   if(response.statusCode==200)
     {
       m=await dataa.fromJson(result);
       if(m!=null){

         setState(() {
           isLoding=false;
         });
       }else{
         print("null");
       }
     }

    setState(() {
      m=dataa.fromJson(result);
    });

    // result.forEach((element) {
    //   print(element);
    //   setState(() {
    //     list.add(dataa.fromJson(element));
    //   });
    // });
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
      body:isLoding? Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(itemCount: m!.data!.length,itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text("${m!.data![index].id}"),
              subtitle: Text("${m!.data![index].userId}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${m!.data![index].address}")
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}
