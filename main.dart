import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Mytask2(),),
  );
}
class Mytask2 extends StatefulWidget {
  @override
  _Mytask2State createState() => _Mytask2State();
}

class _Mytask2State extends State<Mytask2> {
  var cmd;
  var data;
  var fs = FirebaseFirestore.instance;
  myweb(cmd) async {
    var url = "http://192.168.0.108/cgi-bin/web1.py?x=${cmd}";
    var r = await http.get(url);
    setState(() {
      data = r.body;
    });
    print(data);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Run Linuxcommands'),

      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.7,
          color: Colors.lightBlueAccent.shade200,
          child: Column(
            children: <Widget>[
              Text("Enter ur linux cmd :"),
              TextField(
                onChanged: (value) {
                   cmd = value;
                },
              ),
              RaisedButton(
                  onPressed: () {
                    myweb(cmd);
                  },
                  child: Text('output')),
              Text(data ?? "output is coming .."),
              RaisedButton(child : Text("firestore output"),
              onPressed: (){
                fs.collection("linuxcommands").add({
                  cmd:data,
                  });})
            ],),)
          ),
          );}
}
      
  