import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:doc_guard/services/auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doc_guard/models/user.dart';

import 'Modal.dart';
import 'ViewPdf.dart';

// ignore: camel_case_types
class pdf extends StatefulWidget {
  @override
  _pdfState createState() => _pdfState();
}

// ignore: camel_case_types
class _pdfState extends State<pdf> {
  //Future<String> s;
  final FirebaseAuth _authe = FirebaseAuth.instance;
  String xyz;
  List<Modal> itemList=List();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),

      body: itemList.length==0?Center(child: Text("Loading")):ListView.builder(
        itemCount:itemList.length,
        itemBuilder: (context,index){
          return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: GestureDetector(
                onTap: (){
                  String passData=itemList[index].link;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>ViewPdf(),
                          settings: RouteSettings(
                            arguments: passData,
                          )
                      )
                  );
                },
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        height: 140,
                        child: Card(
                          margin: EdgeInsets.all(18),
                          elevation: 7.0,
                          child: Center(
                            child: Text(itemList[index].name+" "+(index+1).toString()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getPdfAndUpload();
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.blueAccent,
      ),

    );
  }

  Future getPdfAndUpload()async{
    var rng = new Random();
    String randomName="";
    for (var i = 0; i < 20; i++) {
      print(rng.nextInt(100));
      print("sahil kanjariya");
      randomName += rng.nextInt(100).toString();
    }
    File file = await FilePicker.getFile(allowedExtensions:['pdf'/*,'jpg'*/],type: FileType.custom);
    String fileName = '$randomName.pdf';
    savePdf(file.readAsBytesSync(), fileName);
  }

  savePdf(List<int> asset, String name) async {
    StorageReference reference = FirebaseStorage.instance.ref().child(name);
    StorageUploadTask uploadTask = reference.putData(asset);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    inputData1(url);
  }

  // ignore: non_constant_identifier_names
  String CreateCryptoRandomString([int length = 32]) {
    final Random _random = Random.secure();
    var values = List<int>.generate(length, (i) => _random.nextInt(256));
    return base64Url.encode(values);
  }

  // void documentFileUpload(String str) {
  //   inputData1(str);
  // }


  @override
  // ignore: must_call_super
  void initState() {
    inputData();
  }

  void inputData() async {
    final FirebaseUser user = await _authe.currentUser();
    final String uid = user.uid.toString();
    print("Hello this is user this is sahil: ");
    print(uid);
    FirebaseDatabase.instance.reference().child('Database').child(uid).once().then((DataSnapshot snap){
      var data = snap.value;
      itemList.clear();
      data.forEach((key,value) {
        Modal m = new Modal(value['PDF'], value['FileName']);
        itemList.add(m);
      });

      setState(() {
        // print("value is ");
        // print(itemList.length);
      });
    });
  }

  void inputData1(String str) async {
    final FirebaseUser user = await _authe.currentUser();
    final String uid = user.uid.toString();
    var data = {
      "PDF": str,
      "FileName":"Doc",
      //   "FileName": new Form(
      //       key: _formKey,
      //       child: Theme(
      // data: new ThemeData(
      // brightness: Brightness.dark, primarySwatch: Colors.teal,
      // inputDecorationTheme: new InputDecorationTheme(
      // labelStyle: new TextStyle(
      // color: Colors.teal, fontSize: 20.0))),
      // child: new Container(
      // padding: const EdgeInsets.all(40.0),
      // child: new Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // children: <Widget>[
      // new TextFormField(
      // decoration: new InputDecoration(
      // labelText: "Enter pdf name",
      // ),
      // keyboardType:   TextInputType.text,
      // validator: (val) => val.isEmpty ? 'Enter pdf name' : null,
      // onChanged: (val){
      // //setState(() => email = val);
      //   return val;
      // },
      // ),
      // ],
      // ),
      // ),
      // ),
      // )
    };
    FirebaseDatabase.instance.reference().child('Database').child(uid).child(CreateCryptoRandomString()).set(data).then((v) {
      print("Store Successfully");
    });
  }
}
