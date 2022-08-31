import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class gunluk extends StatefulWidget{
  late int kullanici_no;
  gunluk(this.kullanici_no);
  @override
  State<StatefulWidget> createState() => _gunluk();

}

class _gunluk extends State<gunluk>{


  void delete(String id){
    FirebaseFirestore.instance.collection('isKayit').doc(id.toString()).delete();
  }

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
        title: Text("Günlük Kazançlarım"),
      ),
      body:  StreamBuilder(
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
            
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                  margin: EdgeInsets.all(10),
                  color: Color.fromARGB(255, 187, 255, 190),
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("İş Adı: " + snapshot.data!.docChanges[index].doc["iş Adı"].toString(),style: TextStyle(fontSize: 18.0),),
                      Text("Giriş Tarihi: " + snapshot.data!.docChanges[index].doc["giriş tarih"].toString(),style: TextStyle(fontSize: 18.0),),
                      Text("Çıkış Tarihi: " + snapshot.data!.docChanges[index].doc["çıkış tarih"].toString(),style: TextStyle(fontSize: 18.0),),
                      Text("Kazanılan Ücret: " + snapshot.data!.docChanges[index].doc["kazanılan Ücret"].toString(),style: TextStyle(fontSize: 18.0),),
                      Text(snapshot.data!.docChanges[index].doc["saat"].toString() + " saat " + snapshot.data!.docChanges[index].doc["dakika"].toString() + " dakika",style: TextStyle(fontSize: 18.0),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: TextButton(
                              child: Text("Sil", style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 247, 3, 3)),),
                              onPressed: (){
                                setState(() {
                                  delete(snapshot.data!.docs[index].id.toString());
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            ),
          );
        },
      ),
    );
  }

}