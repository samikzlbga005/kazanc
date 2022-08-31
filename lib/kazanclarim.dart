import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kazanc/gunluk.dart';

class kazanclarim extends StatefulWidget{
  late int kullanici_no;
  kazanclarim(this.kullanici_no);
  @override
  State<StatefulWidget> createState() => _kazanclarim();
}

class _kazanclarim extends State<kazanclarim> {
  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('isKayit')
          .where(
          'kullanıcı No',
          isEqualTo: widget.kullanici_no,
        ).snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("Kazançlarım"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => gunluk(widget.kullanici_no)));
                  },
                  child: Container(
                  width: 120,
                  height: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green
                  ),
                  child: Text("Günlük",style: TextStyle(fontSize: 17),),
                 )
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: (){
                      
                  },
                  child: Container(
                  width: 120,
                  height: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green
                  ),
                  child: Text("Haftalık",style: TextStyle(fontSize: 17),),
                 )
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: (){
                      
                  },
                  child: Container(
                  width: 120,
                  height: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green
                  ),
                  child: Text("Aylık", style: TextStyle(fontSize: 17),),
                 )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*

body: StreamBuilder(
        stream: _usersStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            padding: EdgeInsets.fromLTRB(10,0,10,0),
            height: 120,
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                  color: Color.fromARGB(255, 187, 255, 190),
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("İş Adı: " + snapshot.data!.docChanges[index].doc["iş Adı"].toString(),style: TextStyle(fontSize: 18.0),),
                    ],
                  ),
                );
              }
            ),
          );
        },
      ),
*/

