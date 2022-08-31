import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kazanc/giris_cikis.dart';
class islerim extends StatefulWidget{
  late int kullanici_no;
  islerim(this.kullanici_no);
  @override
  State<StatefulWidget> createState() => _islerim();
}

class _islerim extends State<islerim> {
  

  late List<int>list = [];
  @override
  void initState() {
    super.initState();
  }

  final isAdiController = TextEditingController();
  final UcretController = TextEditingController();
  final isAdiDuzenleController = TextEditingController();
  final ucretDuzenleController = TextEditingController();
  late String isAdi = "";
  late var ucret = "";

  late String guncelIsadi = "";
  late var guncelUcret = "";


  CollectionReference ref = FirebaseFirestore.instance.collection('islerim');
  //final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance.collection('islerim').snapshots();

  bool isNodogrula = true;
  int isNo = 0;
  
  
  void isNoHesapla()async{
    QuerySnapshot querySnapshot = await ref.get();
    int random = Random().nextInt(99);
    List<int>list = [];
    isNo = random;
    for(int i = 0; i< querySnapshot.size;i++){
      isNodogrula = false;
      break;
    }
    if(isNodogrula){
      isEkle(isNo);
    }
    else{
      isNo = random;
      isNodogrula = true;
      isEkle(isNo);
    }
  }

  void isEkle(int isNo){
    setState(() {
    isAdi = isAdiController.text;
    ucret = UcretController.text;
    isAdiController.clear();
    UcretController.clear();

    ref.add({
        "Kullanıcı No": widget.kullanici_no,
        "isNo": isNo,
        "IsAdi": isAdi,
        "Ucret": ucret,
      });
    });
  }
  
  void delete(String id){
    FirebaseFirestore.instance.collection('islerim').doc(id.toString()).delete();
  }
  
  void update(String ad, String ucret,String id)async{
    isAdiDuzenleController.clear();
    ucretDuzenleController.clear();

    await FirebaseFirestore.instance.collection('islerim').doc(id.toString()).update({
      "IsAdi": ad,
      "Ucret": ucret,
    });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('islerim')
        .where(
          'Kullanıcı No',
          isEqualTo: widget.kullanici_no,
        ).snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("İşlerim"),
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return Card(
                  color: Color.fromARGB(255, 187, 255, 190),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("İş No: " + snapshot.data!.docChanges[index].doc['isNo'].toString(), style: TextStyle(fontSize: 17.0),),
                        Text("İş Adı: " + snapshot.data!.docChanges[index].doc['IsAdi'],style: TextStyle(fontSize: 17.0),),
                        Text("Ücret: " + r"$" + snapshot.data!.docChanges[index].doc['Ucret'],style: TextStyle(fontSize: 17.0),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: TextButton(
                                child: Text("Sil", style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 133, 16, 16)),),
                                onPressed: (){
                                  setState(() {
                                    delete(snapshot.data!.docs[index].id.toString());
                                  });
                                },
                              ),
                            ),
                            Container(
                              child: TextButton(
                                child: Text("Güncelle", style: TextStyle(fontSize: 20.0,color: Color.fromARGB(255, 133, 16, 16)),),
                                onPressed: (){
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                    return SingleChildScrollView(
                                      child: AlertDialog(
                                        title: Text('İş Düzenleme Formu'),
                                        content: Container(
                                          height: 100,
                                          child: Column(
                                            children: <Widget>[
                                              TextField(
                                                controller: isAdiDuzenleController,
                                                decoration: InputDecoration(
                                                hintText: '${snapshot.data!.docChanges[index].doc['IsAdi'].toString()}',
                                                ),
                                              ),
                                              TextField(
                                                controller: ucretDuzenleController,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                hintText:  '${snapshot.data!.docChanges[index].doc['Ucret'].toString()}',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                  primary: Colors.green,
                                                  onPrimary: Colors.white,
                                                  shadowColor: Colors.greenAccent,
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(32.0)),
                                                  minimumSize: Size(100, 40), 
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    if((isAdiDuzenleController.text == "") | (ucretDuzenleController.text == "")){
                                                      Fluttertoast.showToast(msg: "Güncelleme Başarılı");
                                                      Navigator.pop(context);
                                                    }
                                                    else {
                                                      update(isAdiDuzenleController.text, ucretDuzenleController.text,snapshot.data!.docs[index].id.toString());
                                                      Fluttertoast.showToast(msg: "Güncelleme Başarılı");
                                                      Navigator.pop(context);
                                                    }
                                                  });
                                                },
                                                child: Text('Güncelle'),
                                              ),
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                  primary: Colors.green,
                                                  onPrimary: Colors.white,
                                                  shadowColor: Colors.greenAccent,
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(32.0)),
                                                  minimumSize: Size(100, 40), 
                                                ),
                                                onPressed: () {
                                                  isAdiController.text = "";
                                                  UcretController.text = "";
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Kapat'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: (){
          showDialog(
            context: context,
            builder: (context) {
            return SingleChildScrollView(
              child: AlertDialog(
                title: Text('İş Ekleme Formu'),
                content: Container(
                  height: 100,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: isAdiController,
                        decoration: InputDecoration(
                        hintText: 'İş Adı',
                        ),
                      ),
                      TextField(
                        controller: UcretController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                        hintText: 'Saatlik Ücret (örn: 11.30)',
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          onPrimary: Colors.white,
                          shadowColor: Colors.greenAccent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: Size(100, 40), 
                        ),
                        onPressed: () {
                          setState(() {
                            if((isAdiController.text == "") | (UcretController.text == "")){
                              Fluttertoast.showToast(msg: "Lütfen Tüm Alanları Doldurunuz!");
                            }
                            else {
                              isNoHesapla();
                              Fluttertoast.showToast(msg: "Kayıt Başarılı");
                              Navigator.pop(context);
                            }
                          });
                        },
                        child: Text('Kaydet'),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          onPrimary: Colors.white,
                          shadowColor: Colors.greenAccent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: Size(100, 40), 
                        ),
                        onPressed: () {
                          isAdiController.text = "";
                          UcretController.text = "";
                          Navigator.pop(context);
                        },
                        child: Text('Kapat'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        ),
    );
  }
}